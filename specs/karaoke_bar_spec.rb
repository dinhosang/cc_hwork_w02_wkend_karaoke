require('minitest/autorun')
require('minitest/rg')

require_relative('../guest')
require_relative('../song')
require_relative('../karaoke_room')
require_relative('../karaoke_bar')


class TestKaraokeBar < MiniTest::Test

  def setup
    # method for creating tab for guest when they first enter the bar
      # perhaps after entry fee is paid?
    # pay for drinks?
    # method for customer to pay tab when they leave => thing for if they can't

    @bar_name = "Sing Along"
    limit = 20
    till = 500
    entry_fee = 20
    extra_songs_fee = 10

    @the_world = Location.new("Outside the Bar")

    song_name = "lift music"
    style = "Background"
    lyrics = "doo dah dee doo..."
    first_song = Song.new(song_name, style, lyrics)

    song_name = "that music"
    style = "Pop"
    lyrics = "da do wap do wap do dee..."
    second_song = Song.new(song_name, style, lyrics)

    song_name = "handy music"
    style = "Jazz"
    lyrics = "la la ra roo..."
    third_song = Song.new(song_name, style, lyrics)

    @music_cd1 = [first_song, second_song, third_song]

    first_room_name = "Room 1"
    second_room_name = "Room 2"
    third_room_name = "Room 3"

    @first_room = KaraokeRoom.new(first_room_name, 3)

    @second_room = KaraokeRoom.new(second_room_name, 4)

    @third_room = KaraokeRoom.new(third_room_name, 3)


    song_name = "la la music"
    style = "Lindy Hop"
    lyrics = "do wa woo wee boo..."
    @fourth_song = Song.new(song_name, style, lyrics)

    song_name = "ra ra music"
    style = "Military Band"
    lyrics = "ra ra do ra roo..."
    @fifth_song = Song.new(song_name, style, lyrics)

    @music_cd2 = [@fourth_song, first_song]
    @music_cd3 = [second_song, @fifth_song]

    @cd_collection = [@music_cd1, @music_cd2, @music_cd3]


    guest_name = "Sidney"
    @wallet = 50
    @guest = Guest.new(guest_name, @wallet, @fourth_song)

    guest_name = "Jessie"
    @wallet = 50
    @second_guest = Guest.new(guest_name, @wallet, @fourth_song)


    @rooms = [@first_room, @second_room, @third_room]
    @bar = KaraokeBar.new(@bar_name, @cd_collection, @rooms, limit, till, entry_fee, extra_songs_fee, @the_world)

    @guest.enter(@the_world)
    @second_guest.enter(@the_world)
  end


  def test_check_location_name
    actual = @bar.check_name
    expected = @bar_name
    assert_equal(expected, actual)
  end


  def test_check_cd_collection
    actual = @bar.check_cds
    expected = @cd_collection
    assert_equal(expected, actual)
  end


  def test_check_setup_cd_used
    actual = @bar.check_setup_cd_used
    expected = []
    assert_equal(expected, actual)
  end


  def test_check_rooms_at_bar
    actual = @bar.check_rooms
    expected = @rooms
    assert_equal(expected, actual)
  end


  def test_check_limit__20
    actual = @bar.check_limit
    expected = 20
    assert_equal(expected, actual)
  end


  def test_check_till_total
    actual = @bar.till_total
    expected = 500
    assert_equal(expected, actual)
  end


  def test_check_a_room_songlist__empty
    actual = @bar.check_room_songs(@first_room)
    expected = []
    assert_equal(expected,actual)
  end


  def test_update_all_rooms_songlists
    @bar.update_songlists_with_cd(@music_cd1, @first_room)
    actual = @bar.check_room_songs(@first_room)
    expected = @music_cd1
    assert_equal(expected, actual)

    @bar.update_songlists_with_cd(@music_cd2, @first_room)
    actual = @bar.check_room_songs(@first_room)
    expected = @music_cd1.push(@fourth_song)
    assert_equal(expected, actual)

    @bar.update_songlists_with_cd(@music_cd2, @second_room)
    actual = @bar.check_room_songs(@second_room)
    expected = @music_cd2
    assert_equal(expected, actual)
  end


  def test_setup_rooms_with_first_cd
    @bar.setup_rooms_with_first_cd
    actual = @bar.check_room_songs(@second_room)
    expected = @music_cd1

    actual2 = @bar.check_setup_cd_used
    expected2 = [@music_cd1]

    actual3 = @bar.check_cds
    expected3 = [@music_cd2, @music_cd3]

    assert_equal(expected, actual)
    assert_equal(expected2, actual2)
    assert_equal(expected3, actual3)
  end


  def test_update_songlists_with_unused_collection
    @bar.setup_rooms_with_first_cd
    @bar.update_songlists_with_unused_cds(@third_room)

    actual = @bar.check_room_songs(@second_room)
    expected = @music_cd1
    assert_equal(expected, actual)

    actual2 = @bar.check_room_songs(@third_room)
    expected2 = @music_cd1.push(@fourth_song, @fifth_song)
    assert_equal(expected2, actual2)
  end


  def test_check_guest_list
    actual = @bar.check_guest_list
    expected = {@bar => [], @first_room => [], @second_room => [], @third_room => []}
    assert_equal(expected, actual)
  end


  def test_simulate_charging_entry_fee
    actual1 = @bar.charge_fee(@guest, 20)
    expected1 = true

    actual2 = @bar.till_total
    expected2 = 520
    assert_equal(expected1, actual1)
    assert_equal(expected2, actual2)
  end


  def test_check_in_guest__to_bar
    @bar.check_in(@guest, @bar)
    actual = @bar.check_guest_list
    expected = {@bar => [@guest], @first_room => [], @second_room => [], @third_room => []}
    assert_equal(expected, actual)
  end


  def test_bar_receive_guest_and_check_in
    @guest.enter(@bar)

    actual = @bar.check_guest_list
    expected = {@bar => [@guest], @first_room => [], @second_room => [], @third_room => []}
    assert_equal(expected, actual)

    actual2 = @bar.check_occupants
    expected2 = [@guest]
    assert_equal(expected2, actual2)
  end


  def test_check_out_guest_from_room
    @bar.check_in(@guest, @bar)
    actual = @bar.check_guest_list
    expected = {@bar => [@guest], @first_room => [], @second_room => [], @third_room => []}
    assert_equal(expected, actual)

    @bar.check_out(@guest, @bar)
    actual2 = @bar.check_guest_list
    expected2 = {@bar => [], @first_room => [], @second_room => [], @third_room => []}
    assert_equal(expected2, actual2)
  end


  def test_move_and_check_in_guest_to_first_room
    @guest.enter(@bar)

    actual1 = @bar.check_occupants
    expected1 = [@guest]
    assert_equal(expected1, actual1)

    actual2 = @guest.current_location
    expected2 = @bar
    assert_equal(expected2, actual2)

    actual3 = @bar.check_guest_list
    expected3 = {@bar => [@guest], @first_room => [], @second_room => [], @third_room => []}
    assert_equal(expected3, actual3)

    @guest.booked_room = @first_room
    @guest.move_to(@first_room)

    actual4 = @bar.check_occupants
    expected4 = []
    assert_equal(expected4, actual4)

    actual5 = @first_room.check_occupants
    expected5 = [@guest]
    assert_equal(expected5, actual5)

    actual6 = @guest.current_location
    expected6 = @first_room
    assert_equal(expected6, actual6)

    actual7 = @bar.check_guest_list
    expected7 = {@bar => [], @first_room => [@guest], @second_room => [], @third_room => []}
    assert_equal(expected7, actual7)
  end


  def test_move_guest_back_to_bar_from_1st_room
    @guest.enter(@bar)
    @guest.booked_room = @first_room
    @guest.move_to(@first_room)

    actual = @bar.check_guest_list
    expected = {@bar => [], @first_room => [@guest], @second_room => [], @third_room => []}
    assert_equal(expected, actual)

    @guest.move_to(@bar)
    actual = @bar.check_guest_list

    expected = {@bar => [@guest], @first_room => [], @second_room => [], @third_room => []}

    assert_equal(expected, actual)
  end


  def test_show_connecting_rooms
    actual = @bar.show_connecting
    expected = @rooms.unshift(@the_world)
    assert_equal(expected, actual)
  end


  def test_check_bar_has_space__false?
    first_room_name = "Room 1"
    first_room = KaraokeRoom.new(first_room_name, 3)

    rooms = [first_room]

    the_bar = KaraokeBar.new(@bar_name, @cd_collection, rooms, 2, 10, 10, 10, @the_world)

    @guest.move_to(the_bar)
    @second_guest.move_to(the_bar)

    actual = the_bar.has_space?
    expected = false
    assert_equal(expected, actual)

    @second_guest.booked_room = first_room
    @second_guest.move_to(first_room)

    actual = the_bar.has_space?
    expected = false
    assert_equal(expected, actual)
  end


  def test_move_guest__fail_due_to_limit_bar
    first_room_name = "Room 1"
    second_room_name = "Room 2"
    third_room_name = "Room 3"

    first_room = KaraokeRoom.new(first_room_name, 3)

    rooms = [first_room]

    the_bar = KaraokeBar.new(@bar_name, @cd_collection, rooms, 1, 10, 10, 10, @the_world)

    @guest.move_to(the_bar)

    actual = @second_guest.move_to(the_bar)
    expected = false
    assert_equal(expected, actual)
  end

  def test_move_guest__fail_due_to_limit_room
    first_room_name = "Room 1"
    second_room_name = "Room 2"
    third_room_name = "Room 3"

    first_room = KaraokeRoom.new(first_room_name, 1)

    rooms = [first_room]

    the_bar = KaraokeBar.new(@bar_name, @cd_collection, rooms, 2, 10, 10, 10, @the_world)

    @guest.move_to(the_bar)
    @second_guest.move_to(the_bar)

    @guest.book_room(first_room)
    actual = @guest.move_to(first_room)
    expected = true
    assert_equal(expected, actual)

    @second_guest.book_room(first_room)
    actual = @second_guest.move_to(first_room)

    expected = false
    assert_equal(expected, actual)
  end

  def test_move_guest__fail_due_to_no_book
    first_room_name = "Room 1"
    second_room_name = "Room 2"
    third_room_name = "Room 3"

    first_room = KaraokeRoom.new(first_room_name, 3)

    rooms = [first_room]

    the_bar = KaraokeBar.new(@bar_name, @cd_collection, rooms, 1, 10, 10, 10, @the_world)

    @guest.move_to(the_bar)

    actual = @guest.move_to(first_room)
    expected = false
    assert_equal(expected, actual)
  end


  def test_can_allocate_room
    @guest.move_to(@bar)

    actual = @bar.can_allocate_room?(@first_room)
    expected = true
    assert_equal(expected, actual)
  end


  def test_offer_room
    @guest.move_to(@bar)

    actual = @bar.offer_room(@first_room, @guest)
    expected = true
    assert_equal(expected, actual)
  end


  def test_offer_more_songs__success
    actual = @bar.offer_more_songs(@first_room, @guest)
    expected = true
    assert_equal(expected, actual)
  end

  def test_offer_more_songs__fail_no_money
    guest_name = "Jessie"
    wallet = 5
    guest = Guest.new(guest_name, wallet, @fourth_song)

    actual = @bar.offer_more_songs(@first_room, guest)
    expected = false
    assert_equal(expected, actual)
  end

  def test_offer_more_songs__fail_no_more_music
    @bar.update_songlists_with_unused_cds(@first_room)

    guest_name = "Jessie"
    wallet = 5
    guest = Guest.new(guest_name, wallet, @fourth_song)

    actual = @bar.offer_more_songs(@first_room, guest)
    assert_nil(actual)
  end


end
