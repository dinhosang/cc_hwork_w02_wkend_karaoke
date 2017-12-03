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


  def check_not_used_cds
    return @unused_music_cds
  end


  def check_used_cds
    return @used_cds
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


  def setup_rooms_with_first_cd
    first_cd = @unused_music_cds.shift()
    update_songlists_with_cd(first_cd)
    @used_cds.push(first_cd)
  end

  
end
