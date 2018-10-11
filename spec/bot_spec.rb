require_relative '../bot'

RSpec.describe Bot do
  describe '.client' do
    it 'should be Slack::RealTime::Client' do
      bot = Bot.new
      expect bot.client.is_a?(Slack::RealTime::Client)
    end
  end
end
