module PostsHelper
  # return the music player
  def player_for(id)
    first_url  = "https://embed.music.apple.com/us/album/"
    latter_url = "?app=music&amp;itsct=music_box&amp;itscg=30200"
    full_url = first_url + id + latter_url
    tag.iframe(src: full_url, frameborder: 0,
               sandbox: "allow-forms allow-popups allow-same-origin allow-scripts allow-top-navigation-by-user-activation",
               allow: "autoplay * encrypted-media *",
               style: "height: 450px; width: 100%; max-width: 450px; overflow: hidden; border-radius: 10px; background: transparent")
  end
end
