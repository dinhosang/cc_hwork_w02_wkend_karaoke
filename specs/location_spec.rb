require('minitest/autorun')
require('minitest/rg')
require_relative('../location')
require_relative('../guest')
require_relative('../song')


class TestLocation < MiniTest::Test

  def setup
    song_name = "lift music"
    style = "Background"
    lyrics = "doo dah dee doo..."
    favourite_song = Song.new(song_name, style, lyrics)

    first_guest_name = "Sidney"
    second_guest_name = "Mellow"
    wallet = 50

    @first_guest = Guest.new(first_guest_name, wallet, favourite_song)
    @second_guest = Guest.new(second_guest_name, wallet, favourite_song)

    @place_name = "The Place"

    @location = Location.new(@place_name)
  end


  def test_check_location_name
    actual = @location.check_name
    expected = @place_name
    assert_equal(expected, actual)
  end


end