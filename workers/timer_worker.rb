require 'sidekiq'

class TimerWorker
  include Sidekiq::Worker

  def perform(options)
    Timer.new(60)

    Thread.new do

    end
  end
end
