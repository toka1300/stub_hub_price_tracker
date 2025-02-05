require "test_helper"

class PriceAlertsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @main_user = users(:casey)
    @other_user = users(:archer)
    @alert = price_alerts(:one)
    @event = events(:one)
    log_in_as(@main_user)
  end

  # TODO: Test incorrect stubhub url

  test "should show errors but not create alert on invalid submission" do
    assert_no_difference "PriceAlert.count" do
      post price_alerts_path, params: { price_alert: {
                                                      stubhub_url: "haha.com",
                                                      alert_price: 10 } }
    end
    follow_redirect!
    assert_select "div.alert.alert-danger", text: /Incorrect StubHub url/
  end

  test "should create an alert on valid submission" do
    assert_difference "PriceAlert.count", 1 do
      post price_alerts_path, params: { price_alert: {
                                                      user_id: 1,
                                                      stubhub_url: "https://www.stubhub.ca/chicago-the-band-milwaukee-tickets-7-4-2025/event/156455440",
                                                      alert_price: 12345 } }
    end
    assert_redirected_to root_url
  end

  test "main user price alert should show up" do
    post price_alerts_path, params: { price_alert: {
      user_id: 1,
      stubhub_url: "https://www.stubhub.ca/chicago-the-band-milwaukee-tickets-7-4-2025/event/156455440",
      alert_price: 12345 } }
    @main_user.reload
    @main_user.price_alerts.reload
    get root_path
    assert_match "12345", response.body
  end

  test "other user should not see price alert created by main user" do
    post price_alerts_path, params: { price_alert: {
      user_id: 1,
      stubhub_url: "https://www.stubhub.ca/chicago-the-band-milwaukee-tickets-7-4-2025/event/156455440",
      alert_price: 12345 } }
    log_in_as @other_user
    get root_path
    assert_no_match "12345", response.body
  end

  test "should be able to delete own price alert" do
    first_alert = @main_user.price_alerts.first
    assert_difference "PriceAlert.count", -1 do
      delete price_alert_path(first_alert)
    end
    assert_redirected_to root_url
  end
end
