# frozen_string_literal: true

require 'redis'

module RedisWebManager
  class Configuration
    attr_accessor :redis, :authenticate, :interval

    def initialize
      @redis = ::Redis.new
      @authenticate = nil
      @insertion_interval = 1
    end
  end
end
