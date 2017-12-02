require_relative('location')

class KaraokeBar < Location

  def initialize(name, limit, till, entry_fee, bar_tabs)
    super(name, limit)
    @till = till
    @entry_fee = 20
    @bar_tabs = bar_tabs
  end


  def till_total
    return @till
  end


end
