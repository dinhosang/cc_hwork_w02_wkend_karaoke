require_relative('location')

class KaraokeBar < Location

  def initialize(name, limit, till)
    super(name, limit)
    @till = till
  end


  def till_total
    return @till
  end

end
