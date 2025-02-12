class UpdateLivePrice
  include Sidekiq::Worker

  def perform
    expired_events = Event.expired
    expired_events.each do |event|
      puts "Upating: #{event.name}"
    end
    if expired_events.count > 0
      expired_events.each do |event|
        fetch_live_price(event)
      end
    else
      puts "No expired events to update"
    end
  end

  private
    def fetch_live_price(event)
      response = HTTParty.get(event.url)
      json_response = response.parsed_response
      parsed_json = json_response.match(/<script id="index-data" type="application\/json">\s*(.*?)\s*<\/script>/)[1]
      json_data = JSON.parse(parsed_json)
      if json_data["errorMessage"] != "Page Not Found"
        min_price = json_data["grid"]["minPrice"].round
        puts "----------Min Price: #{min_price}"
        event.live_price_cad = min_price
        event.save!
        event.touch unless event.changed?
      else
        puts "Event has passed, updating skipped"
      end
    end
end
