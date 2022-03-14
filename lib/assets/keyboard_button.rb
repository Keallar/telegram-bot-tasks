require 'telegram/bot'

module KeyboardButton
  GET_TASK_EARLY = Telegram::Bot::Types::KeyboardButton.new(text: "Получить задание")
  GET_MOTIVATE = Telegram::Bot::Types::KeyboardButton.new(text: "Мотивация")
  MAIN_MENU = Telegram::Bot::Types::KeyboardButton.new(text: "Главное меню")
  BACK_TO_TASK = Telegram::Bot::Types::KeyboardButton.new(text: "Вернуться к задаче")
end
