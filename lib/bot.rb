require 'telegram/bot'
require 'dotenv/load'
require_relative 'motivate'

class Bot
  def initialize
    token = ENV['TOKEN']

    Telegram::Bot::Client.run(token, logger: Logger.new($stderr)) do |bot|
      bot.logger.info('Bot has been started')
      start_bot_time = Time.now.to_i
      bot.listen do |message|
        case message.text
        when '/start'
          bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}!")
        when '/task'
          bot.api.send_message(chat_id: message.chat.id, text: 'Your task!')
        when '/motivate'
          bot.api.send_message(chat_id: message.chat.id, text: 'Motivation!')
          motivate = Motivate.new
          value = motivate.random
          bot.api.send_message(chat_id: message.chat.id, 
                               text: "#{value['text']}\n#{value['author']}",
                               date: message.date)
        when '/add_task'
          bot.api.send_message(chat_id: message.chat.id, text: 'Added task!')
        when '/stop'
          bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}!")
        else
          bot.api.send_message(chat_id: message.chat.id, text: "Wrong message!!!")
        end
      end
    end
  end
end
