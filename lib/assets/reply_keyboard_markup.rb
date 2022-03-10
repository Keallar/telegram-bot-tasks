require 'telegram/bot'

module ReplyKeyboardMarkup
  REPLY_TASK = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['a'..'z', 'A'..'Z'], one_time_keyboard: true)
end

# puts [('a'..'z'), ('A'..'Z')]
