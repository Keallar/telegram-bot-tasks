require 'net/http'
require 'dotenv/load'
require 'telegram/bot'

class Request
  TOKEN = ENV['TOKEN']

  def self.send_task(chat_id)
    begin
      uri = URI("https://api.telegram.org/bot#{TOKEN}/sendMessage?chat_id=#{chat_id}&text=try")
      res = Net::HTTP.get(uri)
      # bot.logger.info(res)
      puts "REQUEST"
    rescue => e
      bot.logger.error(e.message)
    end
  end
end
