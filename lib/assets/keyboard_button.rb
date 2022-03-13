require 'telegram/bot'

module KeyboardButton
  GET_TASK_EARLY = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: "Получить задание", callback_data: 'get_task_early')
  LEARN_ASNWER = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: "Узнать ответ", callback_data: 'learn_asnwer')
  GET_MOTIVATE = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: "Мотивация", callback_data: 'get_motivate')
  MAIN_MENU = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: "Назад", callback_data: 'main_menu')
  BACK_TO_QUESTION = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: "Вернуться к вопросу", callback_data: 'bac_to_answer')
end
