BASE_URL = 'https://api.darksky.net/forecast'
DARKSKY_API_KEY = ENV['DARKSKY_API_KEY']
DAY_START_TIME= '08:30 AM'
NEW_YORK_COORDINATES = '42.3601,-71.0589'
SLACK_API_TOKEN = ENV['SLACK_API_TOKEN']

ICON_MAPPING = {
  'clear-day': ':sunny:',
  'clear-night': ':last_quarter_moon_with_face:',
  'rain': ':rain_cloud:',
  'snow': ':snowflake: :snowman:',
  'sleet': ':snow_cloud:',
  'wind': ':wind_blowing_face:',
  'fog': ':fog:',
  'cloudy': ':cloud:',
  'partly-cloudy-day': ':partly_sunny:',
  'partly-cloudy-night': ':partly_sunny:'
}
