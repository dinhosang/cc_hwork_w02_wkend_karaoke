class Guest

  def initialize(name, wallet, song)
    @name = name
    @wallet = wallet
    @fav_song = song
  end


  def check_wallet
    return @wallet
  end

end
