require('pry')

require_relative('location')


class KaraokeRoom < Location

  def initialize(name, guest_limit, song_list = [])
    super(name, guest_limit)
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
