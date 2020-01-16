# frozen_string_literal: true

require 'redis'

module RedisWebManager
  class Configuration
    # Attributes
    attr_accessor :redis

    # Methods
    def initialize
      @redis = Redis.new
      check_redis
    end

    private

    def check_redis
      # FIXME: doesn't work
      valid = redis.is_a?(Redis)
      raise ArgumentError, "RedisWebManager doesn't support #{redis.class} (#{redis})" unless valid
    end
  end
end
