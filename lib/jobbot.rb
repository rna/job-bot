require 'telegram/bot'
require 'dotenv/load'

Telegram::Bot::Client.run(ENV['TOKEN']) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id:message.chat.id, text: "Welcome to Personal Job bot :smile:")
    end
  end
end