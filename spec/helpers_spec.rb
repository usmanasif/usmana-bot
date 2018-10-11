require_relative '../helpers'

include Helpers

RSpec.describe do
  describe '.date_from_string' do
    it 'should return first found date in string' do
      date = date_from_string('This is a random date string 22/12/2018')
      expect date.match?(/((\d{2}|\d{1})\/(\d{2}|\d{1})\/\d{4})/)
    end
  end
end
