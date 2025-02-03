require "test_helper"

class PriceAlertTest < ActiveSupport::TestCase
  def setup
    @user = users(:casey)
    @event = events(:one)
    @price_alert = @user.price_alerts.build(alert_price: 10, event: @event)
  end

  test "should be valid" do
    assert @price_alert.valid?
  end

  test "user id should be present" do
    @price_alert.user_id = nil
    assert_not @price_alert.valid?
  end

  test "event id should be present" do
    @price_alert.event_id = nil
    assert_not @price_alert.valid?
  end

  test "price should be present" do
    @price_alert.alert_price = "   "
    assert_not @price_alert.valid?
  end

  test "should be integer" do
    @price_alert.alert_price = "invalid"
    assert_not @price_alert.valid?
  end

  test "order should be nearest date first" do
    assert_equal price_alerts(:nearest_event), PriceAlert.first # TODO: change to nearest date
  end
end
