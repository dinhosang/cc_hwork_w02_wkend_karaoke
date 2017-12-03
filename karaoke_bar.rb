require_relative('location')
require('pry')

class KaraokeBar < Location

  def initialize(name, music_collection, rooms, limit, till, entry_fee, bar_tabs)
    super(name, limit)
    @unused_music_cds = music_collection
    @used_cds = []
    @till = till
    @entry_fee = entry_fee
    @bar_tabs = bar_tabs
    @rooms = rooms
  end


  def till_total
    return @till
  end


  def check_rooms
    return @rooms
  end


  def check_unused_cds
    return @unused_music_cds
  end


  def check_room_songs(location)
    for room in @rooms
      return room.show_songs if room == location
    end
  end


  def update_songlists_with_cd(cd)
      for room in @rooms
        for song in cd
          room.add_song(song)
        end
      end
  end


end
