require_relative('location')

class KaraokeRoom < Location

  def initialize(name, limit, song_list)
    super(name, limit)
    @song_list = song_list
  end


  def show_songs
    return @song_list
  end


  def add_song(song)
      @song_list.push(song)
  end

end
