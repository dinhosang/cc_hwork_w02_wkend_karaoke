require_relative('location')

class KaraokeBar < Location

  def initialize(name, limit, till, bar_tabs)
    super(name, limit)
    @till = till
    @bar_tabs = bar_tabs
  end


  def till_total
    return @till
  end


end
