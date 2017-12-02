require('minitest/autorun')
require('minitest/rg')
require_relative('../guest')
require_relative('../song')


class TestGuest < MiniTest::Test

  def setup
    song_name = "lift music"
    style = "Background"
    lyrics = "doo dah dee doo..."
    @favourite_song = Song.new(song_name, style, lyrics)
    other_song_name = "drop music"
    other_style = "foreground"
    other_lyrics = "wah wah woo..."
    @other_song = Song.new(other_song_name, other_style, other_lyrics)
    name = "Sidney"
    @wallet = 50
    @guest = Guest.new(name, @wallet, @favourite_song)
  end


  def test_check_wallet
    actual = @guest.check_wallet
    expected = @wallet
    assert_equal(expected, actual)
  end


  def test_use_wallet
    @guest.use_wallet(20)
    actual = @guest.check_wallet
    expected = 30
    assert_equal(expected, actual)
  end


  def test_fav_song__true
    actual = @guest.fav_song?(@favourite_song)
    expected = true
    assert_equal(expected, actual)
  end

  def test_fav_song__false
    actual = @guest.fav_song?(@other_song)
    expected = false
    assert_equal(expected, actual)
  end


  # def test_cheer_song__fav_song
  #   actual = @guest.cheer()
  # end

end
