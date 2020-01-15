# frozen_string_literal: true

module RedisWebManager
  class RedisCli
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
