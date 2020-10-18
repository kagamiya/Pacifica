module UsersHelper
  # return a picture for an user icon
  def icon_for(user)
    default_url = "sample.png"
    picture_url = user.picture.url || default_url
    image_tag(picture_url, alt: user.name, class: "user_icon")
  end
end
