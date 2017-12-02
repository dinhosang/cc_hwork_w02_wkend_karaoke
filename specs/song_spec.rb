require('minitest/autorun')
require('minitest/rg')
require_relative('../song')


class TestSong < MiniTest::Test

  def setup
    @name = "lift music"
    @style = "Background"
    @lyrics = "doo dah dee doo..."
    @song = Song.new(@name, @style, @lyrics)
  end


  def test_get_name_of_song
    actual = @song.check_name
    expected = @name
    assert_equal(expected, actual)
  end


  def test_check_style
    actual = @song.check_style
    expected = @style.downcase
    assert_equal(expected, actual)
  end

  def test_read_lyrics
    actual = @song.read_lyrics
    expected = @lyrics
    assert_equal(expected, actual)
  end


end
