# frozen_string_literal: true

module RedisWebManager
  class Base
    def status
      @status ||= redis.ping == 'PONG'
    end

    def host
      @host ||= connection[:host]
    end

    def port
      @port ||= connection[:port]
    end

    def db
      @db ||= connection[:db]
    end

    def dbsize
      @dbsize ||= redis.dbsize
    end

    def id
      @id ||= connection[:id]
    end

    def location
      @location ||= connection[:location]
    end

    def info
      @info ||= redis.info
    end

    def last_save
      @last_save ||= Time.at(redis.lastsave)
    end

    private

    def connection
      @connection ||= redis.connection
    end

    def redis
      @redis ||= RedisWebManager.configuration.redis
    end
  end
end
