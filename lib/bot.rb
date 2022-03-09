require 'telegram/bot'
require 'dotenv/load'
require_relative 'motivation'
require_relative 'tasks'

class Bot
  def initialize
    token = ENV['TOKEN']
    start = false

    Telegram::Bot::Client.run(token, logger: Logger.new($stderr)) do |bot|
      bot.logger.info('Bot has been started')
      start_bot_time = Time.now
      bot.listen do |message|
        cur_bot_time = Time.now
        case message.text
        when '/start'
          bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}! Time: #{cur_bot_time.to_s}")
          start = true
          bot.logger.info('Bot has been started working')
        when '/task'
          bot.api.send_message(chat_id: message.chat.id, text: 'Task!')
          task = Tasks.new
          value = task.random
          bot.api.send_message(chat_id: message.chat.id, 
                               text: "#{value['question']}\n#{value['answer']}",
                               date: message.date
                              )
          bot.logger.info('Task was send')
        when '/motivate'
          bot.api.send_message(chat_id: message.chat.id, text: 'Motivation!')
          motivate = Motivation.new
          value = motivate.random
          bot.api.send_message(chat_id: message.chat.id, 
                               text: "#{value['text']}\n#{value['author']}",
                               date: message.date
                              )
          bot.logger.info('Motivate was send')
        when '/add_task'
          bot.api.send_message(chat_id: message.chat.id, text: 'Added task!')
        when '/stop'
          bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}!")
          start = false
          bot.logger.info('Bot has been started working')
        else
          bot.api.send_message(chat_id: message.chat.id, text: 'Wrong message!!!')
        end
      end
    end
  end
end
