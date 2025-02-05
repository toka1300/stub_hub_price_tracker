require "test_helper"

class EventTest < ActiveSupport::TestCase
  def setup
    @event = events(:one)
  end

  test "should be valid" do
    assert @event.valid?
  end

  test "name should not be blank" do
    @event.name = ""
    assert_not @event.valid?
  end

  test "date should not be blank" do
    @event.date = "    "
    assert_not @event.valid?
  end

  test "venue should not be blank" do
    @event.venue = "    "
    assert_not @event.valid?
  end

  test "live price should not be blank" do
    @event.live_price_cad = "     "
    assert_not @event.valid?
  end

  test "live price should be a number" do
    @event.live_price_cad = "wrong"
    assert_not @event.valid?
  end
end
