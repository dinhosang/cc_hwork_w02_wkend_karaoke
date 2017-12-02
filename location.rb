class Location

  def initialize(name)
    @name = name
    @occupants_list = []
  end


  def check_name
    return @name
  end


  def check_occupants
    return @occupants_list
  end

end
