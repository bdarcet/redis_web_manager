# frozen_string_literal: true

require 'redis'

module RedisWebManager
  class Configuration
    attr_accessor :redis

    def initialize
      @redis = Redis.new
    end
  end
end
