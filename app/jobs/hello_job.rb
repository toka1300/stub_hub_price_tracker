require "sidekiq"

class HelloJob
  include Sidekiq::Job

  def perform
    puts "Hello from inside a background job!!!! Fucker..."
  end

  puts "hello from outside the joborino"

  HelloJob.perform_in(30)

  puts "Hello from AFTER the job"
end
