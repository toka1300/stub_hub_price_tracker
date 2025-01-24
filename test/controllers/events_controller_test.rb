require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @event = events(:one)
  end

  test "should redirect create if not logged in" do
    # post to events_path
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
    assert_redirected_to login_url
  end
end
