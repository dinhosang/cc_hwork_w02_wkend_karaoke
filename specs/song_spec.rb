require('minitest/autorun')
require('minitest/rg')
require_relative('../song')


class TestSong < MiniTest::Test

  def setup
    name = "lift music"
    style = "Background"
    lyrics = "doo dah dee doo..."
    @song = Song.new(name, style, lyrics)
  end


  def test_get_name_of_song
    actual = @song.check_name
    expected = "lift music"
    assert_equal(expected, actual)
  end


  def test_check_style
    actual = @song.check_style
    expected = "background"
    assert_equal(expected, actual)
  end

end
