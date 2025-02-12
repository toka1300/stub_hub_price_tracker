class FetchPricesJob < ApplicationJob
  queue_as :default

  # Create a subsection of events that have 'expired'
  # Every 10 minutes grab that subsection
  # If there are any items, iterate through them to ping stubhub
  # Update the minPrice of each one

  def perform(*args)
    puts "Hello from INSIDE the background job!"
  end
end
