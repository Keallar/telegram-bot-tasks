require 'sidekiq'
require 'telegram/bot'

class TimerWorker
  include Sidekiq::Worker

  def perform(bot, name, sec)
    bot.api.send_message(chat_id: @message.from.id, text: name.to_s)

    sleep(sec)

    bot.api.send_message(chat_id: @message.from.id, text: "Sleep!")
  end
end
