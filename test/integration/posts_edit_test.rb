require 'test_helper'

class PostsEditTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:orange)
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_post_path(@post)
    assert_template 'posts/edit'
    patch post_path(@post), params: { post: { content: "" } }
    assert_not @post.errors.nil?
    assert_template 'posts/edit'
  end

  test "successful edit with friendly forwarding" do
    get edit_post_path(@post)
    log_in_as(@user)
    assert_redirected_to edit_post_url(@post)
    content = "foobar"
    patch post_path(@post), params: { post: { content: content } }
    assert_not flash.empty?
    assert_redirected_to @post
    @post.reload
    assert_equal content, @post.content
  end
end
