class Timer
  def self.check_times
    Time.now
  end

  def self.sleep_o(times = 60)
    sleep(times.minutes)
  end
end
