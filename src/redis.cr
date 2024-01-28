module RedisModule
  def save_to_redis(key : String, value : String, ttl : Int64?)
    redis = Redis::Client.new(uri: URI.parse("#{ENV["REDIS_URL"]}"))
    redis.set(key: key, value: value, ex: ttl || ENV["REDIS_TTL"])
  end

  def get_value_from_redis(key : String)
    redis = Redis::Client.new(uri: URI.parse("#{ENV["REDIS_URL"]}"))
    redis.get(key)
  end

  def delete_from_redis(key : String)
    redis = Redis::Client.new(uri: URI.parse("#{ENV["REDIS_URL"]}"))
    redis.del(key)
  end
end
