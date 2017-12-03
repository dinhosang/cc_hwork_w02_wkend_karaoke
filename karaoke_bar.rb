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
    @connecting_rooms = []
    for room in @rooms
      room_connect(room)
    end
    @guest_list = {self => []}
    for room in @rooms
      @guest_list[room] = []
    end
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


  def check_guest_list
    return @guest_list
  end


  def check_in(guest, location)
    @guest_list[location].push(guest)
  end


  def check_out(guest, location)
    @guest_list[location].delete(guest)
  end


  def receive_occupant(person)
    check_in(person, self)
    @occupants_list.push(person)
  end


  def release_occupant(person, new_location)
    check_in(person, new_location)
    @occupants_list.delete(person)
  end


  def show_connecting
    return @connecting_rooms
  end


  def has_space?
    total_occupants = 0
    for location in @guest_list.keys()
      room_occupants = @guest_list[location].count()
      total_occupants += room_occupants
    end
    return true if total_occupants < @limit
    return false
  end


end
