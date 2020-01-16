# frozen_string_literal: true

module RedisWebManager
  class Info < Base
    def status
      @status ||= redis.ping == 'PONG'
    end

    def info
      @info ||= redis.info
    end

    def last_save
      @last_save ||= Time.at(redis.lastsave)
    end
  end
end