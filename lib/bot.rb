# frozen_string_literal: true

require 'telegram/bot'
require 'dotenv/load'
require_relative 'scraper'

token = ENV['TOKEN']
Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello #{message.from.first_name}, Welcome to Personal Remote Job Board")
      bot.api.send_message(chat_id: message.chat.id, text: 'Please tel me in which technology you are looking for job')
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye #{message.from.first_name}")
    end
  end
end
