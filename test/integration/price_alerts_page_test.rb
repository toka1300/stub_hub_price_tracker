require "test_helper"

class PriceAlertsPageTest < ActionDispatch::IntegrationTest
  include ApplicationHelper
  # TODO: Add test for alert on if it is in the money
  # Input box and track button
  # The number of price alerts matches the number of price alerts set by user

  def setup
    @user = users(:archer)
  end

  test "display of price alerts" do
    get login_path
    log_in_as(@user)
    get root_path
    assert_template "static_pages/home"
    assert_select "title", "StubHub Price Tracker | Home"
    # assert_select "form input[type=search]", 1
    assert_select "form input[type=submit]", 1
    @user.price_alerts.each do |alert|
      assert_match alert.event.venue, response.body
      assert_match alert.event.name, response.body
    end
    assert_select "li.price-alert-card", count: 10
  end
end
