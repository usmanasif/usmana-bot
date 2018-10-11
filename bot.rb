require 'slack-ruby-client'
require_relative 'constants'
require_relative 'helpers'
require_relative 'config/slack'

class Bot
  include Helpers

  attr_accessor :client

  def initialize
    @client = new_client
  end

  def start
    client.on :hello do
      puts "Connected successfully with #{client.self.name}"
    end

    client.on :message do |data|
      message = data.text.downcase if data.text.present?

      case
        when message.include?('weather today')
          handle_weather_today(data)
        when message.include?('weather tomorrow')
          handle_weather_tomorrow(data)
        when message.include?('weather on ')
          handle_weather_on(data, message)
        when message == 'help'
          handle_help(data)
      end
    end

    client.start!

    rescue Slack::Web::Api::Errors::SlackError => e
      puts e.message

    rescue Slack::Web::Api::Errors::TooManyRequestsError => e
      puts e

    rescue Faraday::ClientError => e
      puts e
  end

  def alert_weather_change
    response = weather_details_at(Time.now.to_i + 24*60*60)
    summary = response.dig('alerts', 'description')

    if summary.present?
      channels = channels

      channels.each do |channel| next unless channel['is_member']
        send_message_to_channel(channel['id'], summary)
      end
    else
      send_message_to_channel(channel['id'], 'Sorry! Something went wrong')
    end
  end

  private
    def new_client
      Slack::RealTime::Client.new
    end

    def handle_weather_today(data)
      client.typing(channel: data.channel)
      response = weather_details_at(Time.now.to_i)
      send_weather_response(client, response, data.channel)
    end

    def handle_weather_tomorrow(data)
      client.typing(channel: data.channel)
      response = weather_details_at(Time.now.to_i + 24*60*60)
      send_weather_response(client, response, data.channel)
    end

    def handle_weather_on(data, message)
      client.typing(channel: data.channel)
      date = date_from_string(message)

      return client.message(channel: data.channel, text: 'Invalid Date Format, expected DD/MM/YYYY') if date.blank?

      time = DateTime.parse(date).to_time.to_i
      response = weather_details_at(time)
      send_weather_response(client, response, data.channel)
    end

    def handle_help(data)
      client.typing(channel: data.channel)
      client.message(channel: data.channel, text: help_message)
    end
end
