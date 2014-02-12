class User < ActiveRecord::Base
   def tweet(status)
    tweet = tweets.create!(:status => status)
    TweetWorker.perform_async(tweet.id)
  end
  # Remember to create a migration!
end
