require 'telegram/bot'
require 'dotenv/load'
require_relative 'listener'
require_relative 'timer'
require_relative '../workers/timer_worker'

class Bot
  def initialize
    token = ENV['TOKEN']

    Telegram::Bot::Client.run(token, logger: Logger.new($stderr)) do |bot|
      bot.logger.info('Bot has been started')
      listener = Listener.new(bot)

      bot.listen do |message|
        listener.call(message)

        bot.api.send_message(chat_id: message.from.id, text: Timer.check_times.to_s)

        TimerWorker.perform_async(bot, message.from.first_name, 1)
      end
    end
  end
end
