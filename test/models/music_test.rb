require 'test_helper'

class MusicTest < ActiveSupport::TestCase
  def setup
    @post = posts(:orange)
    @music = @post.build_music(name: "Harlequin", artist: "Lee ritenour", artwork: "harlequin", collection_id: "12345")
  end

  test "should be valid" do
    assert @music.valid?
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

  test "collection id should be present" do
    @music.collection_id = ""
    assert_not @music.valid?
  end

  test "associated music should be destroyed" do
    @post.save
    assert_difference 'Music.count', -1 do
      @post.destroy
    end
  end
end
