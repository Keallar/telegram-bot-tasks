require 'telegram/bot'

module InlineButton
  GET_ANOTHER_TASK = Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Задание', callback_data: 'get_another_task')
  LEARN_ASNWER = Telegram::Bot::Types::InlineKeyboardButton.new(text: "Узнать ответ", callback_data: 'learn_answer')
  GIVE_ANSWER = Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Отправить ответ', callback_data: 'give_answer')
end
