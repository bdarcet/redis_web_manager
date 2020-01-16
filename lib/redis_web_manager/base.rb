# frozen_string_literal: true

module RedisWebManager
  class Base
    def status
      @status ||= redis.ping == 'PONG'
    end

    def last_save
      @last_save ||= Time.at(redis.lastsave)
    end

    private

    def redis
      @redis ||= RedisWebManager.configuration.redis
    end
  end
end
