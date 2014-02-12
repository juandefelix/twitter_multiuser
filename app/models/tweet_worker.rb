class TweetWorker
  include Sidekiq::Worker

  def perform(tweet_id)
    tweet = Tweet.find(tweet_id)
    user  = tweet.user
    access_token = user.oauth_token
    access_secret = user.oauth_secret

    # set up Twitter OAuth client here
    client = Twitter::REST::Client.new do |config|
    config.consumer_key = ENV['TWITTER_KEY']
    config.consumer_secret = ENV['TWITTER_SECRET']
    config.access_token = access_token
    config.access_token_secret = access_secret
    end


    # actually make API call
    client.update(tweet.status)
    # Note: this does not have access to controller/view helpers
    # You'll have to re-initialize everything inside here
  end
end

