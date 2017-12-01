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
    actual = @song.read_name
    expected = "life music"
  end

end
