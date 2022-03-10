require 'telegram/bot'

module KeyboardButton
  GIVE_ANSWER = Telegram::Bot::Types::KeyboardButton.new(text: 'Дать ответ', request: 'give_answer')
  GET_ANSWER = Telegram::Bot::Types::KeyboardButton.new(text: 'Получить ответ', callback_data: 'get_answer')
end
