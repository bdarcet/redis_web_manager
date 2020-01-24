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

    def latency
      @latency ||= redis.latency(:doctor)
    end

    def memory_usage
      @memory_usage ||= redis.info(:memory)
    end

    def last_save
      @last_save ||= Time.at(redis.lastsave)
    end

    def infos_to_save
      { source: 'Redis_web_manager', date: DateTime.now, memory_usage: memory_usage }.to_json
    end

    def clients
      @clients ||= redis.client(:list)
    end

    def redis_web_manager_keys
      @redis_web_manager_keys ||= redis.keys.grep(/^RedisWebManager_/)
    end
  end
end
