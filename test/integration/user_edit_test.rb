require "test_helper"

class UserEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:casey)
  end

  test "unsuccesful edit" do
    get edit_user_path(@user)
    assert_template "users/edit"
    patch user_path(@user), params: { user: { name: "",
                                              email: "fake@invalid",
                                              password: "foo",
                                              password_confirmation: "bar" } }
    assert_response :unprocessable_entity
    assert_template "users/edit"
    assert_select "div.alert-danger", "The form contains 4 errors."
  end
end
