require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    # upload picture fo user icon
      assert_select 'input[type=file]'
      picture = fixture_file_upload('test/fixtures/sample_artwork.png', 'image/png')
    patch user_path(@user), params: { user: { name: "",
                                              email: "foo@invalid",
                                              password: "foo",
                                              password_confirmation: "bar",
                                              picture: picture } }
    assert_template 'users/edit'
    assert_select "div.alert"                                          
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    assert_not session[:forwarding_url].nil?
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    assert session[:forwarding_url].nil?
    name = "foo bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name:name,
                                              email: email,
                                              password: "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email                                              
  end
end
