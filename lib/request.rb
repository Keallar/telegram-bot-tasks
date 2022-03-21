require 'net/http'
require 'dotenv/load'
require 'telegram/bot'
require_relative 'task'
require_relative 'motivation'

class Request
  attr_accessor :task, :answer
  attr_reader :bot

  def initialize(bot)
    @bot = bot
  end

  def send_task(message)
    begin
      @task = Task.send(:new).random
      @answer = @task[:answer]
      @bot.api.send_message(chat_id: message.chat.id, text: 'Задача')
      ikb = [InlineButton::LEARN_ASNWER]
      inline_markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: ikb)
      @bot.api.send_message(chat_id: message.chat.id, text: "#{@task[:question]}", reply_markup: inline_markup)
      @bot.logger.info('Task was send')
    rescue => e
      @bot.logger.error(e.message)
    end
  end
end
