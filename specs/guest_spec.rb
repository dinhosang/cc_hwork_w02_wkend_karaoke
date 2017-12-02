require('minitest/autorun')
require('minitest/rg')
require_relative('../guest')
require_relative('../song')
require_relative('../location')

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

    another_song_name = "drop music"
    another_style = "foreground"
    another_lyrics = "wah wah woo..."
    another_song = Song.new(other_song_name, other_style, other_lyrics)

    @songlist_with_fav = [@other_song, @favourite_song, another_song]
    @songlist_no_fav = [@other_song, another_song]

    @place_name = "The Place"
    @second_place_name = "Another Place"
    @location = Location.new(@place_name)
    @second_location = Location.new(@second_place_name)

    name = "Sidney"
    second_guest_name = "Mellow"
    third_guest_name = "Maddie"

    @wallet = 50
    @guest = Guest.new(name, @wallet, @favourite_song)
    @second_guest = Guest.new(second_guest_name, @wallet, @favourite_song)
    @third_guest = Guest.new(third_guest_name, @wallet, @favourite_song)
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


  def test_cheer_song
    actual = @guest.cheer(@favourite_song)
    expected = "Oh, they have 'lift music'! This is THE song!"
    assert_equal(expected, actual)
  end


  def test_check_songlist_for_fav_song__present
    actual = @guest.check_songlist(@songlist_with_fav)
    expected = "Oh, they have 'lift music'! This is THE song!"
    assert_equal(expected, actual)
  end


  def test_check_songlist_for_fav_song__not_present
    actual = @guest.check_songlist(@songlist_no_fav)
    assert_nil(actual)
  end


  def test_enter_location
    @guest.enter(@location)
    actual = @location.check_occupants
    expected = [@guest]
    assert_equal(expected, actual)
  end


  def test_check_current_location
    @guest.enter(@location)
    actual = @guest.current_location
    expected = @location
    assert_equal(expected, actual)
  end



  def test_leave_location
    @guest.enter(@location)
    @second_guest.enter(@location)
    @third_guest.enter(@location)

    actual = @location.check_occupants
    expected = [@guest, @second_guest, @third_guest]
    assert_equal(expected, actual)

   @second_guest.leave(@location)

   actual = @location.check_occupants
   expected = [@guest, @third_guest]
   assert_equal(expected, actual)
  end


  def test_move_locations
    @guest.enter(@location)
    @guest.
  end


end
