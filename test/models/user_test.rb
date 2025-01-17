require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Casey", email: "casey@casey.com",
                     password: "password", password_confirmation: "password")
    @event = events(:one)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "name shouldn't be too long" do
    @user.name = "y" * 51
    assert_not @user.valid?
  end

  test "email shouldn't be too long" do
    @user.email = "y" * 256
    assert_not @user.valid?
  end

  test "valid emails should be accepted" do
    valid_addresses = %w[ USER@foo.COM THE_US-ER@foo.bar.org first.last@foo.jp ]
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{address.inspect} should be valid email address"
    end
  end

  test "invalid emails should not be accepted" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                        foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |address|
      @user.email = address
      assert_not @user.valid?, "#{address} should be invalid"
    end
  end

  test "email should be present" do
    @user.email = "    "
    assert_not @user.valid?
  end

  test "email should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should not be blank" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should be long enough" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with a nil digest" do
    assert_not @user.authenticated?(:remember, "")
  end

  test "destroying user should destroy associated price alerts" do
    @user.save
    price_alert = @user.price_alerts.build(alert_price: 10, event_id: @event.id)
    price_alert = @user.price_alerts.create!(alert_price: 10, event_id: @event.id)
    @user.destroy
    assert price_alert.destroyed?
  end
end
