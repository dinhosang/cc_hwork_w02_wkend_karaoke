require('pry')

require_relative('location')

class KaraokeRoom < Location

  def initialize(name, limit, song_list = [])
    super(name, limit)
    @songlist = song_list
  end


  def show_songs
    return @songlist
  end


  def add_song(song)
    if !@songlist.include?(song)
      @songlist.push(song)
    end
  end


end
