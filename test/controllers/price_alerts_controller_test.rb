require "test_helper"

class PriceAlertsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @main_user = users(:casey)
    @other_user = users(:archer)
    @price_alert = price_alerts(:one)
  end

    test "should get root" do
      get root_path
      assert_response :success
    end

  test "should redirect create when not logged in" do
    assert_no_difference "PriceAlert.count" do
      post price_alerts_path, params: { price_alert: { alert_price: 10, event_id: 1, user_id: 1 } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference "PriceAlert.count" do
      delete price_alert_path(@price_alert)
    end
    assert_response :see_other
    assert_redirected_to login_url
  end

  test "cannot delete other user's price alert" do
    log_in_as(@other_user)
    assert_no_difference "PriceAlert.count" do
      delete price_alert_path(@price_alert)
    end
    assert_redirected_to root_url
  end

  test "correct user can delete price alert" do
    log_in_as(@main_user)
    assert_difference "PriceAlert.count", -1 do
      delete price_alert_path(@price_alert)
    end
    assert_redirected_to root_url
  end
end
