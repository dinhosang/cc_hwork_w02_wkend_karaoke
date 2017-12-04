require('pry')


class Guest

  attr_accessor :booked_room

  def initialize(name, wallet, song)
    @name = name
    @wallet = wallet
    @fav_song = song
    @current_location = nil
    @booked_room = nil
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
          if @current_location.release_occupant(self, place)
            return true
          end
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
      return true
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


  def book_room(room)
    answer = can_book_room?(room)
    if answer
      success = @current_location.offer_room(room, self)
      return success
    end
    return answer
  end


  def request_more_songs
    if @current_location.class == KaraokeRoom
      connect_rooms = @current_location.show_connecting
      for room in connect_rooms
        if room.class == KaraokeBar
          answer = room.offer_more_songs(@current_location, self)
          return answer
        end
      end
    end
  end


end
