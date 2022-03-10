require 'telegram/bot'
require_relative 'motivation'
require_relative 'tasks'
require_relative 'assets/inline_button'

class Listener
  attr_accessor :message
  attr_reader :bot

  def initialize(bot, message)
    @bot = bot
    @message = message
  end

  def call 
    begin
      case @message
      when Telegram::Bot::Types::Message
        case @message.text
        when '/start'
          @bot.api.send_message(chat_id: @message.chat.id, text: "Hello, #{@message.from.first_name}!")
          start = true
          @bot.logger.info('Bot has been started working')

        when '/task'
          @bot.api.send_message(chat_id: @message.chat.id, text: 'Task!')
          task = Tasks.new
          question = task.random
          @bot.api.send_message(chat_id: @message.chat.id, 
                              text: "#{question}\n}",
                              date: @message.date)
          @bot.logger.info('Task was send')

        when '/motivate'
          @bot.api.send_message(chat_id: @message.chat.id, text: 'Motivation!')
          motivate = Motivation.new
          value = motivate.random
          @bot.api.send_message(chat_id: message.chat.id, 
                              text: "#{value['text']}\n#{value['author']}",
                              date: @message.date)
          @bot.logger.info('Motivate was send')

        when '/add_task'
          @bot.api.send_message(chat_id: @message.chat.id, text: 'Added task!')

        when '/help'
          @bot.api.send_message(chat_id: @message.chat.id, text: 'Help!')

        when '/stop'
          @bot.api.send_message(chat_id: @message.chat.id, text: "Bye, #{message.from.first_name}!")
          start = false
          @bot.logger.info('Bot has been started working')

        else
          ikb = [InlineButton::GET_TASK,
                InlineButton::GET_MOTIVATE]
          markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: ikb)
          @bot.api.send_message(chat_id: @message.chat.id, text: 'Make a choice', reply_markup: markup)
        end

      when Telegram::Bot::Types::CallbackQuery
        case @message.data
        when 'get_task'
          task = Tasks.new
          question = task.random
          @bot.api.send_message(chat_id: @message.chat.id,
                              text: "#{question}\n}",
                              date: @message.date)
          @bot.logger.info('Task was send')
          bot.api.send_message(chat_id: @message.from.id, text: "Give task")

        when 'get_motivate'
          motivate = Motivation.new
          value = motivate.random
          bot.api.send_message(chat_id: @message.chat.id, 
                              text: "#{value['text']}\n#{value['author']}",
                              date: @message.date)
          bot.logger.info('Motivate was send')
        else
          bot.api.send_message(chat_id: @message.from.id, text: "Error!")
        end
      end
    rescue => exception
      bot.logger.info(exception.message)
    end
  end
end

# case message
# when Telegram::Bot::Types::CallbackQuery
#   case message.data 
#   when 'give_answer'
#     bot.api.send_message(chat_id: message.from.id, text: "Give answer")
#   when 'get_answer'
#     bot.api.send_message(chat_id: message.from.id, text: "Get answer")
#   end

# when Telegram::Bot::Types::Message  
#   ikb = [InlineButton::GIVE_ANSWER,
#          InlineButton::GET_ANSWER
#   ]
#   markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: ikb)
#   bot.api.send_message(chat_id: message.chat.id, text: 'Make a choice', reply_markup: markup)
# end