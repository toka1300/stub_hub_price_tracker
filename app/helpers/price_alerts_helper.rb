require "net/http"
require "json"

module PriceAlertsHelper
  def fetch_event_data(url)
    response = HTTParty.get(url)
    json_response = response.parsed_response
    parsed_json = json_response.match(/<script id="index-data" type="application\/json">\s*(.*?)\s*<\/script>/)[1]
    json_data = JSON.parse(parsed_json)
    if json_data["errorMessage"] != "Page Not Found"
      currency = json_data["grid"]["formattedMinPrice"][0]
      exchange_rate = currency == "C" ? 1 : usd_to_cad
      {
        name: json_data["eventName"],
        date: json_data["formattedEventDateTime"],
        venue: json_data["venueName"],
        live_price_cad: 1000,
        # live_price_cad: (json_data["grid"]["minPrice"] * exchange_rate).round, #TODO: Put this line back in
        url: url,
        stubhub_id: json_data["eventId"],
        image_url: json_data["categoryImageUrl"]
      }
    else
      puts "-------No matching JSON data found------"
      nil
    end
  end
end

private
  def usd_to_cad
    uri = URI("https://api.exchangerate-api.com/v4/latest/usd")
    response = Net::HTTP.get(uri)
    json = JSON.parse(response)
    json["rates"]["CAD"]
  end
