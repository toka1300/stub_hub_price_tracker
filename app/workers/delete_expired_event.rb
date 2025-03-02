class DeleteExpiredEvent
  include Sidekiq::Worker

  def perform
    completed_events = Event.completed
    puts "Completed Events: ------->#{completed_events}"
    if completed_events.empty?
      puts "No past events to delete"
    else
      completed_events.each do |event|
        puts "-----Deleting: #{event.name}"
        event.destroy
      end
    end
  end
end
