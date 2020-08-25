require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "",
                                              email: "foo@invalid",
                                              password: "foo",
                                              password_confirmation: "bar",
                                              picture: "" } }
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
    # upload picture for user icon
    picture = fixture_file_upload('test/fixtures/sample.png', 'image/png')
    patch user_path(@user), params: { user: { name:name,
                                              email: email,
                                              password: "",
                                              password_confirmation: "",
                                              picture: picture } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
    assert @user.picture?
    assert_equal "/uploads/user/picture/#{@user.id}/sample.png", @user.picture.url                                        
  end
end
