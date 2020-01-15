module RedisWebManager
  class Redis

    private

    def connection
      @connection ||= redis.connection
    end

    def info
      @info ||= redis.info
    end

    def redis
      @redis ||= RedisWebManager.configuration.redis
    end
  end
end