require 'rubygems'
require 'bundler/setup'
require 'twitter'
require 'json'

class TwitterApi
  def self.our_public_tweets
    client.user_timeline('Root_Solutions', count: 5, exlude_replies: true, include_rts: false)
  end

  def self.client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
    end
  end
end