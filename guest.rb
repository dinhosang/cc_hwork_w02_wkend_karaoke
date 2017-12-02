class Guest

  def initialize(name, wallet, song)
    @name = name
    @wallet = wallet
    @fav_song = song
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


  def check_songlist(songlist)
    return cheer(@fav_song) if songlist.include?(@fav_song)
    return nil
  end


  def enter(location)
    location.receive_occupant(self)
  end

end
