require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:one)
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

  test "should get new page" do
    get new_event_path
    assert_response :success
  end
end
