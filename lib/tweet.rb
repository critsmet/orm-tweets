class Tweet

  attr_accessor :id, :user_id, :message

  def initialize(attr_hash)
    attr_hash.each {|key, value| self.send("#{key}=", value)}
  end

  def save
    if self.id && DB.execute("SELECT * FROM tweets WHERE id = ?", self.id).length == 1
      sql = "UPDATE tweets SET user_id = ?, message = ? WHERE id = ?"
      DB.execute(sql, self.user_id, self.message, self.id)
    else
      sql = "INSERT INTO tweets (user_id, message) VALUES (?, ?)"
      DB.execute(sql, self.user_id, self.message)
      self.id = DB.execute("SELECT last_insert_rowid() FROM tweets")[0][0]
    end
  end

  def self.all
    sql = "SELECT * FROM tweets"
    all_tweets = DB.execute(sql)
    all_tweets.map {|tweet_info| Tweet.new(tweet_info)}
  end

  def self.setup_table
    sql = "CREATE TABLE IF NOT EXISTS tweets (id INTEGER PRIMARY KEY, user_id INTEGER, message TEXT)"
    DB.execute(sql)
  end

end
