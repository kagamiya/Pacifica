require 'test_helper'

class PostInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "valid post with music data" do
    log_in_as(@user)
    get new_post_path
    assert_template 'posts/new'
    # params
    content = "post content"
    name    =       "stuff"
    artist  =       "stuff"
    artwork =       "sample.png"
    collection_id = "12345"

    # invalid post
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: "", music_attributes: {} } }
    end
    assert_select 'div#error_explanation'

    # invalid post without music data
    assert_no_difference ['Post.count', 'Music.count'] do
      post posts_path, params: { post: { content: content,
                                         music_attributes: { name: "",
                                                             artist: "",
                                                             artwork: "",
                                                             collection_id: "" } } }
    end
    assert_select 'div#error_explanation'

    # valid post with music data
    assert_difference ['Post.count', 'Music.count'], 1 do
      post posts_path, params: { post: { content: content,
                                         music_attributes: { name: name,
                                                             artist: artist,
                                                             artwork: artwork,
                                                             collection_id: collection_id } } }
    end
    post = @user.posts.paginate(page: 1).first
    assert_redirected_to post
    follow_redirect!
    assert_match content, response.body
    assert_match name,    response.body
    assert_match artist,  response.body
    assert_select 'img',  src: artwork

    # access wrong user profile (and confirm delete links are not there)
    get user_path(users(:archer))
    assert_select 'a', text: "delete", count: 0
    assert_select 'a', text: "edit",   count: 0
  end
end
