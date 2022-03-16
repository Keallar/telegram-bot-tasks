require 'telegram/bot'
require 'dotenv/load'
require 'logger'
require_relative 'listener'

class Bot
  TOKEN = ENV['TOKEN']

  def initialize
    begin
      Telegram::Bot::Client.run(TOKEN, logger: Logger.new($stderr)) do |bot|
        bot.logger.info('Bot has been started')
        listener = Listener.new(bot)

        bot.listen do |message|
          # Thread.start(message) do |rqst|
            listener.call(message)
          # end
        end
      end
    rescue => e
      @bot.logger.error(e.message)
    end
  end
end
