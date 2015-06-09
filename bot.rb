require File.expand_path('../config/environment', __FILE__)

require 'slack'
require 'logger'

logger = Logger.new(STDOUT)
logger.level = Logger::INFO

Slack.configure do |config|
  config.token = SLACK_BOT_TOKEN
end

auth = Slack.auth_test
fail auth['error'] unless auth['ok']

client = Slack.realtime

client.on :hello do
  logger.info 'successfully connected'
end

client.on :message do |data|
  msg = Message.create(:channel => data['channel'], :user => data['user'] || "bot", :message => data['text'], :team => data['team'], :ts => data['ts'])
  Sunspot.index! msg
  if data['text'] == 'ping'
    Slack.chat_postMessage channel: data['channel'], text: "@#{data['user']}: pong"
  elsif data['text'] == 'historia'
    Slack.chat_postMessage channel: data['channel'], text: "@#{data['user']}: #{HISTORY_LINK}"
  end
end

client.start