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


  def test_check_limit__default_nil
    actual = @location.check_limit
    assert_nil(actual)
  end


  def test_check_limit__5
    location = Location.new(@place_name, 5)
    actual = location.check_limit
    expected = 5
    assert_equal(expected, actual)
  end


  def test_check_occupants
    actual = @location.check_occupants
    expected = []
    assert_equal(expected, actual)
  end


  def test_receive_occupant
    @location.receive_occupant(@first_guest)
    actual = @location.check_occupants
    expected = [@first_guest]
    assert_equal(expected, actual)
  end


  def test_release_occupant
    @location.receive_occupant(@first_guest)

    actual = @location.check_occupants
    expected = [@first_guest]
    assert_equal(expected, actual)

    @location.release_occupant(@first_guest)

    actual2 = @location.check_occupants
    expected2 = []
    assert_equal(expected2, actual2)
  end


end
