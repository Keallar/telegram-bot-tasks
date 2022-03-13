require 'telegram/bot'
require_relative 'motivation'
require_relative 'tasks'
require_relative 'assets/inline_button'
require_relative 'assets/keyboard_button'

class Listener
  attr_accessor :message, :have_task, :task, :answer, :have_answer
  attr_reader :bot

  def initialize(bot)
    @bot = bot
    @have_task = false
    @have_answer = false
    @task = nil
    @answer = nil
    @message = nil
  end

  def call(message)
    @message = message
    begin
      case @message
      when Telegram::Bot::Types::CallbackQuery
        query_call

      when Telegram::Bot::Types::Message
        message_call
      end
    rescue => e
      @bot.logger.info(e.message)
    end
  end

  def query_call
    case @message.data

    when 'get_motivate'
      motivate = Motivation.new
      value = motivate.random
      bot.logger.info('Motivate was send')
      bot.api.send_message(chat_id: @message.from.id, text: "#{value['text']}\n#{value['author']}")

    when 'give_answer'
      bot.api.send_message(chat_id: @message.from.id, text: "Answer")

    when 'get_task_early'
      @have_task = true
      kb = [KeyboardButton::MAIN_MENU, KeyboardButton::LEARN_ASNWER]
      markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: kb)
      @bot.api.send_message(chat_id: @message.chat.id, text: 'Get task early', reply_markup: markup)

    when 'learn_answer'
      @have_task = false

    when 'back_to_answer'
      bot.api.send_message(chat_id: @message.from.id, text: 'Back to answer')

    when 'main_menu'
      kb = [KeyboardButton::GET_TASK_EARLY, KeyboardButton::GET_MOTIVATE]
      markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: kb)
      @bot.logger.info('Main menu')
      @bot.api.send_message(chat_id: @message.chat.id, text: 'Main menu', reply_markup: markup)

    else
      bot.api.send_message(chat_id: @message.from.id, text: "Error!")
    end
  end

  def message_call
    case @message.text
    when '/start'
      kb = [KeyboardButton::GET_TASK_EARLY, KeyboardButton::GET_MOTIVATE]
      markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: kb)
      @bot.api.send_message(chat_id: @message.chat.id, text: 'Start', reply_markup: markup)
      @bot.logger.info('Bot has been started working')

    when '/add_task'
      @bot.api.send_message(chat_id: @message.chat.id, text: 'Added task!')

    when '/help'
      @bot.api.send_message(chat_id: @message.chat.id, text: 'Help!')

    when '/stop'
      @bot.api.send_message(chat_id: @message.chat.id, text: "Bye, #{@message.from.first_name}!")
      @start = false
      @bot.logger.info('Bot has been started working')

    else
      if @have_task.eql?(true)
        bot.logger.info(@message.text)
        @bot.api.send_message(chat_id: @message.chat.id, text: 'Else answer!')
      end
    end
  end
end
