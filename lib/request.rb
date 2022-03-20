require 'net/http'
require 'dotenv/load'
require 'telegram/bot'

class Request
  TOKEN = ENV['TOKEN']

  def self.send_task(bot, message)
    begin
      # uri = URI("https://api.telegram.org/bot#{TOKEN}/sendMessage?chat_id=#{message.from.chat_id}&text=try")
      # res = Net::HTTP.get(uri)
      bot.api.send_message(chat_id: message.from.id, text: 'Задание')
      # bot.logger.info(res)
      puts "REQUEST"
    rescue => e
      bot.logger.error(e.message)
    end
  end
end
