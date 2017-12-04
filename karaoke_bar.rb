require('pry')

require_relative('location')


class KaraokeBar < Location

  def initialize(name, music_collection, rooms, guest_limit, till, entry_fee, extra_songs_fee, location_outside_of_bar)
    super(name, guest_limit)
    @music_cds = music_collection
    @setup_cd_used = []
    @till = till
    @entry_fee = entry_fee
    @extra_songs_fee = extra_songs_fee
    @bar_tabs = {}
    @rooms = rooms
    @outside = location_outside_of_bar
    @connecting_rooms = []
    room_connect(@outside)
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


  def receive_occupant(person, old_location)
    @occupants_list.push(person)
    check_in(person, self)
    if old_location != nil
      if old_location != @outside
        check_out(person, old_location)
      end
    end
  end


  def release_occupant(person, new_location)
    if new_location != @outside
      if person.booked_room == new_location
        check_in(person, new_location)
      else
        return false
      end
    end
    check_out(person, self)
    @occupants_list.delete(person)
  end


  def show_connecting
    return @connecting_rooms
  end


  def has_space?
    total_occupants = 0
    locations = @guest_list.keys()
    for location in locations
      room_occupants = @guest_list[location].length()
      total_occupants += room_occupants
    end
    return true if total_occupants < @limit
    return false
  end


  def charge_fee(guest, amount)
    if guest.use_wallet(amount)
      @till += amount
      return true
    end
    return false
  end


  def can_allocate_room?(room)
    return true if room.has_space?
    return false
  end


  def offer_room(room, guest)
    if charge_fee(guest, @entry_fee)
      guest.booked_room = room
      return true
    end
    return false
  end


  def offer_more_songs(room, guest)
    remaining_music = []
    music_in_room = room.show_songs
    for cd in @music_cds
      remaining_music.concat(cd)
    end
    for song in remaining_music
      if !music_in_room.include?(song)
        if charge_fee(guest, @extra_songs_fee)
          update_songlists_with_unused_cds(room)
          return true
        else
          return false
        end
      end
    end
    return nil
  end

end
