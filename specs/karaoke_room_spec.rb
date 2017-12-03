require('minitest/autorun')
require('minitest/rg')
require_relative('../guest')
require_relative('../song')
require_relative('../karaoke_room')


class TestKaraokeRoom < MiniTest::Test

  def setup
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
    @third_song = Song.new(song_name, style, lyrics)

    song_list = [first_song, second_song, @third_song]

    @check_song_list = [first_song, second_song, @third_song]

    @room_name = "Room 1"

    @karaoke_room = KaraokeRoom.new(@room_name, 3, song_list)
  end


  def test_check_location_name
    actual = @karaoke_room.check_name
    expected = @room_name
    assert_equal(expected, actual)
  end


  def test_check_limit__3
    actual = @karaoke_room.check_limit
    expected = 3
    assert_equal(expected, actual)
  end


  def test_show_song_list
    actual = @karaoke_room.show_songs
    expected = @check_song_list
    assert_equal(expected, actual)
  end


  def test_add_songs_to_room_songlist
    song_name = "la la music"
    style = "Lindy Hop"
    lyrics = "do wa woo wee boo..."

    fourth_song = Song.new(song_name, style, lyrics)

    @karaoke_room.add_song(fourth_song)

    actual = @karaoke_room.show_songs.include?(fourth_song)
    expected = true

    assert_equal(expected, actual)
  end


  def test_add_song_to_room__song_already_there
    actual1 = @karaoke_room.show_songs
    expected1 = @check_song_list
    assert_equal(expected1, actual1)

    song_name = "la la music"
    style = "Lindy Hop"
    lyrics = "do wa woo wee boo..."
    fourth_song = Song.new(song_name, style, lyrics)

    @karaoke_room.add_song(fourth_song)
    @karaoke_room.add_song(@third_song)

    actual2 = @karaoke_room.show_songs
    expected2 = @check_song_list.push(fourth_song)
    assert_equal(expected2, actual2)
  end

end
