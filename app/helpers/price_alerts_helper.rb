module PriceAlertsHelper
  def fetch_event_data(url)
    response = HTTParty.get(url)
    json_response = response.parsed_response
    parsed_json = json_response.match(/<script id="index-data" type="application\/json">\s*(.*?)\s*<\/script>/)[1]
    if parsed_json
      json_data = JSON.parse(parsed_json)
      {
        name: json_data["eventName"],
        date: json_data["formattedEventDateTime"],
        venue: json_data["venueName"],
        live_price_cad: json_data["grid"]["minPrice"].round,
        url: url,
        stubhub_id: json_data["eventId"],
        image_url: json_data["categoryImageUrl"]
      }
    else
      puts "No matching JSON data found"
    end
  end
end
