require('minitest/autorun')
require('minitest/rg')
require_relative('../guest')
require_relative('../song')
require_relative('../karaoke_room')
require_relative('../karaoke_bar')

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

    @cds = [@songlist_with_fav, @songlist_no_fav]

    @place_name = "The Place"
    @second_place_name = "Another Place"
    @location = Location.new(@place_name, 3)
    @second_location = Location.new(@second_place_name, 1)

    name = "Sidney"
    second_guest_name = "Mellow"
    third_guest_name = "Maddie"

    @wallet = 50
    @guest = Guest.new(name, @wallet, @favourite_song)
    @second_guest = Guest.new(second_guest_name, 10, @favourite_song)
    @third_guest = Guest.new(third_guest_name, @wallet, @favourite_song)

    @karaoke_room = KaraokeRoom.new(@place_name, 3, @songlist_with_fav)
    @second_karaoke_room = KaraokeRoom.new(@place_name, 0, @songlist_no_fav)

    @rooms = [@karaoke_room, @second_karaoke_room]

    @the_world = Location.new("Outside the Bar")

    @bar = KaraokeBar.new(@bar_name, @cds, @rooms, 20, 200, 20, 10, {}, @the_world)

    @third_karaoke_room = KaraokeRoom.new(@place_name, 3)

    @the_bar = KaraokeBar.new(@bar_name, @cds, [@third_karaoke_room], 20, 200, 20, 10, {}, @the_world)
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


  def test_check_songlist_for_fav_song__present
    @guest.enter(@karaoke_room)

    actual = @guest.check_song_list
    expected = "Oh, they have 'lift music'! This is THE song!"

    assert_equal(expected, actual)
  end

  def test_check_songlist_for_fav_song__not_present
    @guest.enter(@second_karaoke_room)
    actual = @guest.check_song_list
    assert_nil(actual)
  end


  def test_leave_to_location
   @location.room_connect(@second_location)

    @guest.enter(@location)
    @second_guest.enter(@location)
    @third_guest.enter(@location)

    actual = @location.check_occupants
    expected = [@guest, @second_guest, @third_guest]
    assert_equal(expected, actual)

    @second_guest.leave_to(@second_location)

    actual = @location.check_occupants
    expected = [@guest, @third_guest]
    assert_equal(expected, actual)
  end


  def test_move_locations__success
    @location.room_connect(@second_location)

    @guest.enter(@location)
    @guest.move_to(@second_location)

    actual1 = @location.check_occupants
    expected1 = []
    assert_equal(expected1, actual1)

    actual2 = @second_location.check_occupants
    expected2 = [@guest]
    assert_equal(expected2, actual2)

    actual3 = @guest.current_location
    expected3 = @second_location
    assert_equal(expected3, actual3)
  end

  def test_move_locations__failure
    @location.room_connect(@second_location)

    @guest.enter(@location)
    @second_guest.enter(@location)
    @guest.move_to(@second_location)
    @second_guest.move_to(@second_location)

    actual1 = @location.check_occupants
    expected1 = [@second_guest]
    assert_equal(expected1, actual1)

    actual2 = @second_guest.current_location
    expected2 = @location
    assert_equal(expected2, actual2)
  end


  def test_inquire_room__can_book
    @guest.enter(@the_world)
    @guest.move_to(@bar)
    actual = @guest.can_book_room?(@karaoke_room)
    expected = true
    assert_equal(expected, actual)
  end

  def test_inquire_room__cannot_book_not_bar
    @guest.enter(@the_world)
    actual = @guest.can_book_room?(@karaoke_room)
    assert_nil(actual)
  end

  def test_inquire_room__cannot_book_full
    @guest.enter(@the_world)
    @guest.move_to(@bar)
    actual = @guest.can_book_room?(@second_karaoke_room)
    expected = false
    assert_equal(expected, actual)
  end


  def test_update_booked_room
    @guest.booked_room = @karaoke_room
    actual = @guest.booked_room
    expected = @karaoke_room
    assert_equal(expected, actual)
  end


  def test_book_room__success
    @guest.enter(@the_world)
    @guest.move_to(@bar)

    actual = @guest.book_room(@karaoke_room)
    expected = true
    assert_equal(expected, actual)

    actual = @guest.booked_room
    expected = @karaoke_room
    assert_equal(expected, actual)
  end

  def test_book_room__fail_no_money
    @second_guest.enter(@the_world)
    @second_guest.move_to(@bar)
    actual = @second_guest.book_room(@karaoke_room)
    expected = false
    assert_equal(expected, actual)

    actual = @second_guest.booked_room
    assert_nil(actual)
  end


  def test_request_more_songs
    @guest.enter(@the_world)
    @guest.move_to(@the_bar)

    @guest.book_room(@third_karaoke_room)
    @guest.move_to(@third_karaoke_room)

    actual = @guest.request_more_songs
    expected = true
    assert_equal(expected, actual)
  end


end
