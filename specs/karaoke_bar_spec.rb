require('minitest/autorun')
require('minitest/rg')
require_relative('../guest')
require_relative('../song')
require_relative('../karaoke_room')
require_relative('../karaoke_bar')



class TestKaraokeBar < MiniTest::Test

  def setup
    # make outside world 'room' for guests to start in
    # method for updating songlist for all rooms at once
    # method for creating tab for guest when they first enter the bar
      # perhaps after entry fee is paid?
    # pay for drinks? better room/songs?
    # method for customer to pay tab when they leave => thing for if they can't
    # check-in list of where guests are
    # check-out of list when guests leave a room
    # message when room is too full to check in

    @bar_name = "Sing Along"
    limit = 12
    till = 500
    entry_fee = 20
    bar_tabs = {}


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

    @second_room = KaraokeRoom.new(second_room_name, 3)

    third_room = KaraokeRoom.new(third_room_name, 3)


    song_name = "la la music"
    style = "Lindy Hop"
    lyrics = "do wa woo wee boo..."
    @fourth_song = Song.new(song_name, style, lyrics)

    song_name = "ra ra music"
    style = "Military Band"
    lyrics = "ra ra do ra roo..."
    fifth_song = Song.new(song_name, style, lyrics)

    @music_cd2 = [@fourth_song, first_song]
    music_cd3 = [second_song, fifth_song]

    @cd_collection = [@music_cd1, @music_cd2, music_cd3]

    @rooms = [@first_room, @second_room, third_room]
    @bar = KaraokeBar.new(@bar_name, @cd_collection, @rooms, limit, till, entry_fee, bar_tabs)
  end


  def test_check_location_name
    actual = @bar.check_name
    expected = @bar_name
    assert_equal(expected, actual)
  end


  def test_check_unused_cd_collection
    actual = @bar.check_unused_cds
    expected = @cd_collection
    assert_equal(expected, actual)
  end


  def test_check_rooms_at_bar
    actual = @bar.check_rooms
    expected = @rooms
    assert_equal(expected, actual)
  end


  def test_check_limit__12
    actual = @bar.check_limit
    expected = 12
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
    @bar.update_songlists_with_cd(@music_cd1)
    actual = @bar.check_room_songs(@first_room)
    expected = @music_cd1
    assert_equal(expected, actual)

    @bar.update_songlists_with_cd(@music_cd2)
    actual = @bar.check_room_songs(@second_room)
    expected = @music_cd1.push(@fourth_song)
    assert_equal(expected, actual)
  end


end
