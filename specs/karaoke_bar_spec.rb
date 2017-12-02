require('minitest/autorun')
require('minitest/rg')
require_relative('../guest')
require_relative('../song')
require_relative('../karaoke_room')
require_relative('../karaoke_bar')



class TestKaraokeBar < MiniTest::Test

  def setup
    @bar_name = "Sing Along"
    limit = 12
    till = 500
    bar_tabs = {}
    @bar = KaraokeBar.new(@bar_name, limit, till, bar_tabs)
  end


  def test_check_location_name
    actual = @bar.check_name
    expected = @bar_name
    assert_equal(expected, actual)
  end


  def test_check_limit__12
    actual = @bar.check_limit
    expected = 12
    assert_equal(expected, actual)
  end


  def test_check_till_total
    actual = @bar.till_total
    expected = 500
    assert_equal(expected, actual)
  end


end
