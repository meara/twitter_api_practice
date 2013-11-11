class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :tweets



  def fetch_tweets!
    tweets_array = Twitter.user_timeline(self.username, count: 10)
    tweets_array.each do |tweet|
      self.tweets.create(text: tweet.text)
    end  
  end

  def tweets_stale? 
    stale_time = Time.now - 1.minutes
    self.tweets.each do |tweet|
      return false if tweet.created_at > stale_time
    end
    true
  end

end
