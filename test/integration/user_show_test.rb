require "test_helper"

class UserShowTest < ActionDispatch::IntegrationTest
  def setup
    @activated_user = users(:archer)
    @unactivated_user = users(:jimmy)
  end

  test "redirected to homepage when accessing unactivated user's page" do
    get user_path(@unactivated_user)
    assert_response :redirect
    assert_redirected_to root_path
  end
  test "should display user when activated" do
    get user_path(@activated_user)
    assert_response :success
    assert_template "users/show"
  end
end
