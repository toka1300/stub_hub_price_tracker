require "test_helper"

class PriceAlertTest < ActiveSupport::TestCase
  def setup
    @user = users(:casey)
    @event = events(:one)
    @price_alert = PriceAlert.new(alert_price: 10, user_id: @user.id)
    puts @price_alert
  end

  test "should be valid" do
    assert @price_alert.valid?
  end

  test "user id should be present" do
    @price_alert.user_id = nil
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
end
