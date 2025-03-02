class UpdateLivePrice
  include Sidekiq::Worker

  def perform
    expired_events = Event.expired

    if expired_events.count > 0
      expired_events.each do |event|
        puts "Fetching price for #{event.name}"
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
        currency = json_data["grid"]["formattedMinPrice"][0]
        exchange_rate = currency == "C" ? 1 : usd_to_cad
        puts "USD: #{json_data["grid"]["minPrice"]}, Exchange Rate: #{exchange_rate}"
        min_price = (json_data["grid"]["minPrice"] * exchange_rate).round
        puts min_price
        event.live_price_cad = min_price
        event.save!
        event.touch unless event.changed?
      end
    end

    def update_alerts(event)
      begin
        puts "price has dropped on #{event.name}, checking alerts"
        alerts = PriceAlert.where(event_id: event)
        alerts.each do |alert|
          if event.live_price_cad < alert.alert_price
            puts "It has fallen below alert set for #{alert}"
            alert.alert_user = true
            alert.save!
            puts "I will send the email now"
            UserMailer.alert_user(alert.user, alert).deliver_now
          end
        end
      rescue => e
        puts "Error in update_alerts: #{e.message}"
        puts e.backtrace.join("\n")
        $stdout.flush
      end
    end

    def usd_to_cad
      uri = URI("https://api.exchangerate-api.com/v4/latest/usd")
      response = Net::HTTP.get(uri)
      json = JSON.parse(response)
      json["rates"]["CAD"]
    end
end
