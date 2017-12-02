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

end
