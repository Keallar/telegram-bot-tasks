require 'telegram/bot'
require 'dotenv/load'
require 'logger'
require_relative 'listener'

class Bot
  attr_reader :client

  TOKEN = ENV['TOKEN']
  LOGGER = Logger.new($stderr)

  def initialize
    @client = Telegram::Bot::Client.new(TOKEN, logger: LOGGER)
    logger = Logger.new('log/bot_logs.log')

    begin
      @client.run do |bot|
        bot.logger.info('Bot has been started')
        listener = Listener.new(bot)

        bot.listen do |message|
          Thread.start(message) do |rqst|
            listener.call(rqst)
          end
        end
      end
    rescue => e
      bot.logger.error(e.message)
      logger.error(e.message)
    end
  end
end
