require_relative '../config/environment.rb'

chris = User.new(username: "Chris")
chris.save

chris_tweet_1 = Tweet.new(user_id: chris.id, message: "First tweet!")
chris_tweet_1.save
