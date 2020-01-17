# frozen_string_literal: true

module RedisWebManager
  class Command < Base
    def flushdb
      redis.flushdb
    end

    def pause
      redis.client(:pause, 60_000)
    end
  end
end