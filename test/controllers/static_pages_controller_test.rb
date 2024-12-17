require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "StubHub Price Tracker | Contact"
  end

  test "should get help page" do
    get help_path
    assert_response :success
    assert_select "title", "StubHub Price Tracker | Help"
  end
end
