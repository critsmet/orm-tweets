require 'sqlite3'
require 'pry'

DB = SQLite3::Database.new('db/tweet_orm.db')
DB.results_as_hash = true

require_relative '../lib/tweet.rb'
require_relative '../lib/user.rb'

Tweet.setup_table
User.setup_table

require_relative '../db/seed.rb'
