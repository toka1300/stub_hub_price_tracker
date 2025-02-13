class UpdateLivePrice
  include Sidekiq::Worker

  def perform
    expired_events = Event.expired

    if expired_events.count > 0
      expired_events.each do |event|
        puts event.name
        old_price = event.live_price_cad
        fetch_live_price(event)
        new_price = event.live_price_cad
        puts "Old: #{old_price}, new: #{new_price}"
        if new_price < old_price
          update_alerts(event)
        end
      end
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
        # puts "----------Min Price: #{min_price}"
        event.live_price_cad = min_price
        event.save!
        event.touch unless event.changed?
        # Need a check to say, if alert price < live price, then put class on.
      end
    end

    def update_alerts(event)
      puts "price has dropped on #{event.name}, checking alerts"
      alerts = PriceAlert.where(event_id: event)
      alerts.each do |alert|
        if event.live_price_cad < alert.alert_price
          alert.alert_user = true
          alert.save!
        end
      end
    end
end
