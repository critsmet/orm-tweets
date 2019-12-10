class User

  attr_accessor :id, :username

  def initialize(attr_hash)
    attr_hash.each {|key, value| self.send("#{key}=", value)}
  end

  def save
    if self.id && DB.execute("SELECT * FROM users WHERE id = ?", self.id).length == 1
      sql = "UPDATE tweets SET username = ? WHERE id = ?"
      DB.execute(sql, self.username, self.id)
    else
      sql = "INSERT INTO users (username) VALUES (?)"
      DB.execute(sql, self.username)
      self.id = DB.execute("SELECT last_insert_rowid() FROM users")[0][0]
    end
  end

  def tweets
    sql = "SELECT * FROM tweets WHERE id = ?"
    tweets = DB.execute(sql, self.id)
    tweets.map {|tweet_attr| Tweet.new(tweet_attr)}
  end

  def self.find_by_username(username)
    sql = "SELECT * FROM users WHERE username = ?"
    users_array = DB.execute(sql, username)
    User.new(users_array[0])
  end

  def self.setup_table
    sql = "CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, username TEXT)"
    DB.execute(sql)
  end

end
