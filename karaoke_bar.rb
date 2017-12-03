require_relative('location')

class KaraokeBar < Location

  def initialize(name, rooms, limit, till, entry_fee, bar_tabs)
    super(name, limit)
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


end
