require 'net/http'
require 'dotenv/load'

class Request
  TOKEN = ENV['TOKEN']

  def self.send_task(chat_id)
    uri = URI("https://api.telegram.org/bot#{TOKEN}/sendMessage?chat_id=#{chat_id}&text=try")
    res = Net::HTTP.get(uri)
    puts res
  end
end
