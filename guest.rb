require('pry')
require_relative('karaoke_bar')


class Guest

  attr_writer :current_location

  def initialize(name, wallet, song)
    @name = name
    @wallet = wallet
    @fav_song = song
    @current_location = nil
  end


  def check_wallet
    return @wallet
  end


  def use_wallet(amount)
    if @wallet >= amount
      @wallet -= amount
      return true
    end
    return false
  end


  def fav_song?(song)
    return @fav_song == song
  end


  def cheer(song)
    song_name = song.check_name
    return "Oh, they have '#{song_name}'! This is THE song!"
  end


  def check_song_list
    songs = @current_location.show_songs
    if songs.include?(@fav_song)
      return cheer(@fav_song)
    end
    return nil
  end


  def enter(location)
    previous_location = @current_location
    location.receive_occupant(self, previous_location)
    @current_location = location
  end


  def leave_to(location)
    for place in @current_location.show_connecting
      if place == location
        if place.has_space?
          @current_location.release_occupant(self, place)
          return true
        end
      end
    end
    return false
  end


  def current_location
    return @current_location
  end


  def move_to(location)
    if leave_to(location)
      enter(location)
    end
    return false
  end


  def can_book_room?(room)
    if @current_location.class == KaraokeBar
      if @current_location.can_allocate_room?(room)
        return true
      end
      return false
    end
    return nil
  end


end
