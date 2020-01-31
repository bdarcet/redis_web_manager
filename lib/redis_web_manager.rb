# frozen_string_literal: true

require 'redis_web_manager/engine'
require 'redis_web_manager/base'
require 'redis_web_manager/action'
require 'redis_web_manager/connection'
require 'redis_web_manager/info'
require 'redis_web_manager/data'
require 'redis'

module RedisWebManager
  mattr_accessor :redis, default: ::Redis.new
  mattr_accessor :authenticate, default: nil
  mattr_accessor :lifespan, default: 15.days

  class << self
    def configure
      yield self if block_given?
      check_attrs
    end

    private

    def check_attrs
      unless redis.is_a?(::Redis)
        raise ArgumentError, 'Invalid Redis instance, use like that Redis.new'
      end
      unless lifespan.is_a?(ActiveSupport::Duration)
        raise ArgumentError, 'Invalid lifespan, use like that 15.days, 15.minutes etc'
      end
    end
  end
end
