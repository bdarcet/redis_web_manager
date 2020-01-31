# frozen_string_literal: true

module RedisWebManager
  class Info < Base
    def status
      @status ||= redis.ping == 'PONG'
    end

    def stats
      @stats ||= redis.info
    end

    def keys
      @keys ||= redis.keys
    end

    def type(key)
      redis.type(key)
    end

    def get(key)
      redis.get(key)
    end

    def llen(key)
      redis.llen(key)
    end

    def lrange(key, start, stop)
      redis.lrange(key, start, stop)
    end

    def smembers(key)
      redis.smembers(key)
    end

    def zrange(key, start, stop, options = {})
      redis.zrange(key, start, stop, options)
    end

    def hgetall(key)
      redis.hgetall(key)
    end

    def dbsize
      @dbsize ||= redis.dbsize
    end

    def configuration
      @configuration ||= redis.config(:get, '*')
    end

    def clients
      @clients ||= redis.client(:list)
    end
  end
end
