require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    get root_path
    assert_template "price_alerts/index"
    assert_select "a[href=?]", root_path, count: 4
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", contact_path
  end
end
