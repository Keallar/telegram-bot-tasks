require 'telegram/bot'
require 'dotenv/load'
require_relative 'listener'
require_relative 'timer'

class Bot
  def initialize
    token = ENV['TOKEN']
    start = false

    Telegram::Bot::Client.run(token, logger: Logger.new($stderr)) do |bot|
      bot.logger.info('Bot has been started')
      start_bot_time = Time.now
      bot.listen do |message|
        cur_bot_time = Time.now

        Listener.new(bot, message).call

        bot.api.send_message(chat_id: message.from.id, text: "#{Timer.check_times}")

      end
    end
  end
end
