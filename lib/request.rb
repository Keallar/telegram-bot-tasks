require 'net/http'
require 'dotenv/load'
require 'telegram/bot'

class Request
  TOKEN = ENV['TOKEN']

  def self.send_task
    begin
      Telegram::Bot::Client.run(TOKEN, logger: Logger.new($stderr)) do |bot|
        bot.logger.info('Request bot')

        bot.listen do |message|
          uri = URI("https://api.telegram.org/bot#{TOKEN}/sendMessage?chat_id=#{message.chat.chat_id}&text=try")
          res = Net::HTTP.get(uri)
          puts res
        end
      end
    rescue => e
      bot.logger.error(e.message)
    end
  end
end
