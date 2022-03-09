require 'telegram/bot'

module InlineButton
  GIVE_ANSWER = Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Дать ответ', callback_data: 'give_answer')
  GET_ANSWER = Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Получить ответ', callback_data: 'get_answer')
  GET_TASK = Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Задание', callback_data: 'get_task')
  GET_MOTIVATE = Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Мотвация', callback_data: 'get_motivate')
end