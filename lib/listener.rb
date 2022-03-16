require 'telegram/bot'
require_relative 'motivation'
require_relative 'task'
require_relative 'assets/inline_button'
require_relative 'assets/keyboard_button'

class Listener
  attr_accessor :message, :have_task, :task, :answer
  attr_reader :bot

  def initialize(bot)
    @bot = bot
    @have_task = false
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
      @bot.logger.error(e.message)
      @bot.logger.error(e.backtrace)
    end
  end

  def query_call
    case @message.data

    when 'learn_answer'
      @have_task = false
      kb = [KeyboardButton::GET_TASK_EARLY, KeyboardButton::GET_MOTIVATE]
      markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: kb, resize_keyboard: true)
      @bot.api.send_message(chat_id: @message.from.id, text: "#{@task[:answer]}", reply_markup: markup)
      @task = nil
      @answer = nil

    else
      bot.api.send_message(chat_id: @message.from.id, text: "Error!")
    end
  end

  def message_call
    case @message.text
    when '/start'
      kb = [KeyboardButton::GET_TASK_EARLY, KeyboardButton::GET_MOTIVATE]
      markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: kb, resize_keyboard: true)
      @bot.logger.info('Bot has been started working')
      @bot.api.send_message(chat_id: @message.chat.id, text: 'Start', reply_markup: markup)

    when 'Мотивация'
      motivate = Motivation.new
      value = motivate.random
      bot.logger.info('Motivate was send')
      bot.api.send_message(chat_id: @message.from.id, text: "#{value['text']}\n#{value['author']}")

    when 'Получить задание'
      @task = Task.send(:new).random
      @answer = @task[:answer]
      @have_task = true
      kb = [KeyboardButton::MAIN_MENU]
      reply_markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: kb, resize_keyboard: true)
      bot.logger.info('Task was send')
      @bot.api.send_message(chat_id: @message.chat.id, text: 'Задача', reply_markup: reply_markup)
      ikb = [InlineButton::LEARN_ASNWER]
      inline_markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: ikb)
      @bot.api.send_message(chat_id: @message.chat.id, text: "#{@task[:question]}", reply_markup: inline_markup)

    when 'Вернуться к задаче'
      if @task
        kb = [KeyboardButton::MAIN_MENU]
        reply_markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: kb, resize_keyboard: true)
        bot.logger.info('Task was send again')
        @bot.api.send_message(chat_id: @message.chat.id, text: " Возврат", reply_markup: reply_markup)
        ikb = [InlineButton::LEARN_ASNWER]
        inline_markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: ikb)
        @bot.api.send_message(chat_id: @message.chat.id, text: "#{@task[:question]}", reply_markup: inline_markup)
      end

    when 'Главное меню'
      kb = []
      if @have_task == true
        kb = [KeyboardButton::BACK_TO_TASK, KeyboardButton::GET_TASK_EARLY, KeyboardButton::GET_MOTIVATE]
      else
        kb = [KeyboardButton::GET_TASK_EARLY, KeyboardButton::GET_MOTIVATE]
      end
      markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: kb, resize_keyboard: true)
      @bot.logger.info('Main menu')
      @bot.api.send_message(chat_id: @message.chat.id, text: 'Main menu', reply_markup: markup)

    when '/help'
      @bot.api.send_message(chat_id: @message.chat.id, text: 'Help!')

    when '/settings'
      @bot.api.send_message(chat_id: @message.chat.id, text: 'Settings!')

    when '/stop'
      rkr = Telegram::Bot::Types::ReplyKeyboardRemove.new
      markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: rkr, resize_keyboard: true)
      @bot.api.send_message(chat_id: @message.chat.id, text: "Bye, #{@message.from.first_name}!", reply_markup: markup)
      @start = false
      @bot.logger.info('Bot has been started working')
    end
  end
end
