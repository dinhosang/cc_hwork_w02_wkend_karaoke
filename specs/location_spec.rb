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


  def test_location_has_space__nil_true
    @location.receive_occupant(@first_guest)

    actual = @location.has_space?
    expected = true
    assert_equal(expected, actual)
  end


  def test_location_has_space__value_true
    location = Location.new(@place_name, 2)
    location.receive_occupant(@first_guest)

    actual = location.has_space?
    expected = true
    assert_equal(expected, actual)
  end


  def test_location_has_space__false
    location = Location.new(@place_name, 1)
    location.receive_occupant(@first_guest)

    actual = location.has_space?
    expected = false
    assert_equal(expected, actual)
  end


  def test_show_connecting_rooms
    location = Location.new(@place_name, 1)

    actual = location.show_connecting
    expected = []
    assert_equal(expected, actual)
  end


  def test_set_connecting_rooms
    location = Location.new(@place_name, 1)
    @location.room_connect(location)

    actual = @location.show_connecting
    expected = [location]

    actual2 = location.show_connecting
    expected2 = [@location]

    assert_equal(expected, actual)
    assert_equal(expected2, actual2)
  end


end
