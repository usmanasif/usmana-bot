# usmana-bot

## Introduction ##
This repository holds a Slack bot which reports weather from DarkSky API.

## Gems Used ##
- async-websocket
- dotenv-rails
- httparty
- slack-ruby-client
- whenever

## Usage ##

Run `bundle install` to install gems.

Create a `.env` file in project directory and set the following keys:
```
SLACK_API_TOKEN=[slackbot_token_here]
DARKSKY_API_KEY=[darksky_api_token]
```
Open up a bash terminal and run `ruby application.rb` and wait for connection success message.
The bot will now respond to messages.

**Commands** <br/>

| Command                   | Description                          |
| -----------------------   | -----------------------------------  |
| `weather today`           |Shows the weather for today           |
| `weather tomorrow`        |Shows the weather for tomorrow        |
| `weather on [dd/mm/yyyy]` |Shows the weather for specified date  |


**Setting up Morning Alerts**
Run `whenever --update--crontab` in project directory

*Note: To remove cronjob run `whenever -c`*

