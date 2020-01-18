# frozen_string_literal: true

module RedisWebManager
  class Command < Base
    def flushdb
      redis.flushdb
    end
  end
end