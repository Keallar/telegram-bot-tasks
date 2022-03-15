class Timer
  attr_accessor :countdown

  def initialize(countdown)
    @countdown = countdown
  end

  def self.check_times
    Time.now
  end

  def self.sleep_o(times = 60)
    sleep(times.minutes)
  end
end
