require 'test_helper'

class MusicTest < ActiveSupport::TestCase
  
  def setup
    @post = posts(:orange)
    @music = @post.build_music(name: "Harlequin", artist: "Lee ritenour", artwork: "harlequin_artwork")
  end

  test "should be valid" do
    assert @music.valid?
  end

  test "post id should be present" do
    @music.post_id = nil
    assert_not @music.valid?
  end

  test "name should be present" do
    @music.name = ""
    assert_not @music.valid?
  end

  test "artist should be present" do
    @music.artist = ""
    assert_not @music.valid?
  end

  test "artwork should be present" do
    @music.artwork = ""
    assert_not @music.valid?
  end
end
