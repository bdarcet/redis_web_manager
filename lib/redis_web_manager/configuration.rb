# frozen_string_literal: true

require 'redis'

module RedisWebManager
  class Configuration
    attr_accessor :redis, :authenticate

    def initialize
      @redis = ::Redis.new
      @authenticate = nil
    end
  end
end
