require 'test_helper'

class PostInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end

  test "post interface" do
    log_in_as(@user)
    get new_post_path
    assert_template 'posts/new'
    # invalid post
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: "" } }
    end
    assert_select 'div#error_explanation'

    # valid post
    content = "This post is valid"
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { content: content } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body # valid post is showed at home feed
    first_post = @user.posts.paginate(page: 1).first
    get post_path(first_post)
    assert_match content, response.body # valid post is showed at posts show

    # delete post
    assert_select 'a', text: "delete"
    assert_difference 'Post.count', -1 do
      delete post_path(first_post)
    end

    # access wrong user profile (and confirm delete links are not there)
    get user_path(users(:archer))
    assert_select 'a', text: "delete", count: 0
    assert_select 'a', text: "edit",   count: 0
  end

  test "valid post with music data" do
    log_in_as(@user)
    get new_post_path
    assert_template 'posts/new'
    # params
    content = "post with music data"
    name    =       "stuff"
    artist  =       "stuff"
    artwork =       "stuff"
    collection_id = "12345"
    # invalid post without music data
    assert_no_difference ['Post.count', 'Music.count'] do
      post posts_path, params: { post: { content: content,
                                         music_attributes: { name: "" } } }
    end
    assert_select 'div#error_explanation'
    post = @user.posts.paginate(page: 1).first
    assert_not post.errors.nil?
    assert post.music.nil?
    
    # valid post with music data
    assert_difference ['Post.count', 'Music.count'], 1 do
      post posts_path, params: { post: { content: content,
                                         music_attributes: { name: name } } }
    end
    post = @user.posts.paginate(page: 1).first
    assert_equal content, post.content
    assert_equal name,    post.music.name
  end
end
