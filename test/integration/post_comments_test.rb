require 'test_helper'

class PostCommentsTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @post = posts(:ants)
    log_in_as(@user)
  end

  test "invalid comment" do
    get post_path(@post)
    assert_template 'posts/show'
    assert_no_difference 'Comment.count' do
      post comments_path, params: { comment: { user_id: @user.id, post_id: @post.id, content: "" } }
    end
    assert_not flash.empty?
    # assert_select 'div#error_explanation'
  end

  test "valid comment" do
    get post_path(@post)
    assert_template 'posts/show'
    assert_difference 'Comment.count', 1 do
      post comments_path, params: { comment: { user_id: @user.id, post_id: @post.id, content: "comment content" } }
    end
    assert_redirected_to post_url(@post)
    follow_redirect!
    comment = @user.comments.first
    assert_match comment.user.name, response.body
    assert_match comment.content,   response.body
  end
end
