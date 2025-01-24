require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:one)
  end

  test "layout links" do
    get root_path
    assert_template "price_alerts/index"
    assert_select "a[href=?]", root_path, count: 3
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", events_path
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", contact_path
    user = users(:casey)
    log_in_as user
    get root_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(user)
    assert_select "a[href=?]", edit_user_path(user)
    assert_select "form[action=?]", logout_path
  end

  test "should get index page" do
    get events_path
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get edit page" do
    get event_path(@event)
    assert_response :success
  end
end
