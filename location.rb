class Location

  def initialize(name, limit = nil)
    @name = name
    @occupants_list = []
    @limit = limit
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

  def release_occupant(person)
    @occupants_list.delete(person)
  end

end
