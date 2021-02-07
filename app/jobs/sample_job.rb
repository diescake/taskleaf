class SampleJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Sidekiq::Logging.logger.info 'Hello Sidekiq World !!'
    puts 'Hello Sidekiq World !!'
  end
end
