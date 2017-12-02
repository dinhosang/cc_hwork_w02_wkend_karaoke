require('minitest/autorun')
require('minitest/rg')
require_relative('../guest')
require_relative('../song')


class TestGuest < MiniTest::Test

  def setup
    song_name = "lift music"
    style = "Background"
    lyrics = "doo dah dee doo..."
    favourite_song = Song.new(song_name, style, lyrics)
    name = "Sidney"
    @wallet = 50
    @guest = Guest.new(name, @wallet, favourite_song)
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


end
