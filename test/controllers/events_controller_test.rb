require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @event = events(:one)
    @user = users(:casey)
  end

  test "should not create event if not logged in" do
    assert_no_difference "Event.count" do
      post events_path, params: { event: {
                                            name: "test",
                                            date: "Tuesday, Feb 6th",
                                            venue: "arena",
                                            live_price_cad: 10,
                                            url: "example.com",
                                            event_type: "sports",
                                            image_url: "example-image.org" } }
    end
  end

  test "should add event if logged in" do
    log_in_as @user
    assert_difference "Event.count", 1 do
      post events_path, params: { event: {
                                            name: "test",
                                            date: "Tuesday, February 6th, 2025",
                                            venue: "arena",
                                            live_price_cad: 10,
                                            url: "example.com",
                                            event_type: "sports",
                                            image_url: "example-image.org",
                                            stubhub_id: "stub123" } }
    end
  end
  test "should not add event if logged in and incorrect info" do
    log_in_as @user
    assert_no_difference "Event.count" do
      post events_path, params: { event: {
                                            name: "    ",
                                            date: "Tuesday, February 6th, 2025",
                                            venue: "arena",
                                            live_price_cad: 10,
                                            url: "example.com",
                                            event_type: "sports",
                                            image_url: "example-image.org",
                                            stubhub_id: "stub123" } }
    end
  end
end
