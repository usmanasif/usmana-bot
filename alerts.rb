require 'dotenv/load'
require_relative 'bot'

abort 'DARKSKY_API_KEY is not set' unless ENV.key?('DARKSKY_API_KEY')
abort 'SLACK_API_TOKEN is not set' unless ENV.key?('SLACK_API_TOKEN')

weather_bot = Bot.new
weather_bot.alert_weather_change
