require File.expand_path('../config/environment', __FILE__)
require 'open-uri'
require 'json'

key = SLACK_BOT_TOKEN
channels = open("https://slack.com/api/channels.list?token=#{key}").read
JSON.parse(channels)["channels"].each do |channel|
  Dictionary.where(:uid => channel["id"], :obj_type => 'channel').first_or_create do |chan_db|
    chan_db.value = channel["name"]
  end
end

users = open("https://slack.com/api/users.list?token=#{key}").read
JSON.parse(users)["members"].each do |user|
  Dictionary.where(:uid => user["id"], :obj_type => 'user').first_or_create do |usr_db|
    if user["real_name"].blank?
      usr_db.value = user["name"]
    else
      usr_db.value = user["real_name"]
    end
  end
end
