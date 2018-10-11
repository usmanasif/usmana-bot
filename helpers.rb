require 'httparty'
require_relative 'constants'

module Helpers

  def weather_details_at(time)
    HTTParty.get("#{BASE_URL}/#{DARKSKY_API_KEY}/#{NEW_YORK_COORDINATES},#{time}?exclude=daily,minutely,flags")
  end

  def send_weather_response(client, response, channel)
    if response['hourly'].blank?
      client.message channel: channel, text: weather_response_failed_response
    else
      client.message channel: channel, text: weather_details(response)
    end
  end

  def weather_response_failed_response
    'Sorry to let you down. Service unavailable, check back later! :slightly_smiling_face:'
  end

  def weather_details(response)
    icon = ICON_MAPPING[response['hourly']['icon'].to_sym]
    "#{icon}
    *Summary* #{response['hourly']['summary']}
    *Temperature* #{response['currently']['temperature'].to_i} Fahrenheit (feels like #{response['currently']['apparentTemperature'].to_i})
    *Humidity* #{(response['currently']['humidity']*100).to_i}%
    *Chance of Rain* #{(response['currently']['precipProbability'] * 100).to_i}%"
  end

  def channels
    response = HTTParty.get("https://slack.com/api/conversations.list?token=#{SLACK_API_TOKEN}&types=private_channel,public_channel")
    response['channels']
  end

  def send_message_to_channel(channel_id, message)
    options = {
      body: {
        token: SLACK_API_TOKEN,
        channel: channel_id,
        text: message
      }
    }

    HTTParty.post('https://slack.com/api/chat.postMessage', options)
  end

  def help_message
    'I respond to:
      *Weather today*: Today\'s weather
      *Weather tomorrow*: Tomorrow\'s weather
      *Weather on [dd/mm/yyyy]*: Weather on specified date
    '
  end

  def date_from_string(string)
    matches = string.match(/((\d{2}|\d{1})\/(\d{2}|\d{1})\/\d{4})/)
    matches[0] unless matches.nil?
  end
end
