# frozen_string_literal: true

module RedisWebManager
  class Command < Base
    def flushall
      redis.flushall
    end

    def flushdb
      redis.flushdb
    end
  end
end