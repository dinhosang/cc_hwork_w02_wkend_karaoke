class Guest

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
    @wallet -= amount
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
      location.receive_occupant(self)
      @current_location = location
  end


  def leave_to(location)
    if location.has_space?
      @current_location.release_occupant(self)
      return true
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
  end


end
