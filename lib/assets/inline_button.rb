require 'telegram/bot'

module InlineButton
  GET_TASK = Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Задание', callback_data: 'get_task')
  GET_MOTIVATE = Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Мотвация', callback_data: 'get_motivate')
end
