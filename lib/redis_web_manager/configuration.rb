# frozen_string_literal: true

require 'redis'

module RedisWebManager
  class Configuration
    attr_accessor :redis, :authenticate, :interval, :lifespan

    def initialize
      @redis = ::Redis.new
      @authenticate = nil
      @interval = 10
      @lifespan = 30
    end

    # FIXME: check configuration
  end
end
