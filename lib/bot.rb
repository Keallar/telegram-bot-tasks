require 'telegram/bot'
require 'dotenv/load'
require_relative 'listener'

class Bot
  def initialize
    token = ENV['TOKEN']
    start = false

    Telegram::Bot::Client.run(token, logger: Logger.new($stderr)) do |bot|
      bot.logger.info('Bot has been started')
      start_bot_time = Time.now
      bot.listen do |message|
        cur_bot_time = Time.now

        Listener.new(message, bot).request

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
      end
    end
  end
end
