class Location

  def initialize(name, limit = nil)
    @name = name
    @occupants_list = []
    @limit = limit
    @connecting_rooms = []
  end


  def check_name
    return @name
  end


  def check_limit
    return @limit
  end


  def check_occupants
    return @occupants_list
  end


  def receive_occupant(person)
    @occupants_list.push(person)
  end


  def release_occupant(person, new_location = "not needed")
    @occupants_list.delete(person)
  end


  def has_space?
    return true if @limit == nil
    return true if @occupants_list.size() < @limit
    return false
  end


  def show_connecting
    return @connecting_rooms
  end


  def room_connect(location)
    loc_connecting_room = location.show_connecting
    @connecting_rooms.push(location)
    loc_connecting_room.push(self)
  end


end
