require_relative('location')
require('pry')

class KaraokeBar < Location

  def initialize(name, music_collection, rooms, limit, till, entry_fee, bar_tabs)
    super(name, limit)
    @music_cds = music_collection
    @setup_cd_used = []
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


  def check_cds
    return @music_cds
  end


  def check_setup_cd_used
    return @setup_cd_used
  end


  def check_room_songs(location)
    for room in @rooms
      return room.show_songs if room == location
    end
  end


  def update_songlists_with_cd(cd, location)
      for room in @rooms
        if room == location
          for song in cd
            room.add_song(song)
          end
        end
      end
  end


  def setup_rooms_with_first_cd
    first_cd = @music_cds.shift()
    for room in @rooms
      update_songlists_with_cd(first_cd, room)
    end
    @setup_cd_used.push(first_cd)
  end


  def update_songlists_with_unused_cds(room)
    for cd in @music_cds
      update_songlists_with_cd(cd, room)
    end
  end


end
