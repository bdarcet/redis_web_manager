# frozen_string_literal: true

require 'redis_web_manager/engine'
require 'redis_web_manager/base'
require 'redis_web_manager/action'
require 'redis_web_manager/connection'
require 'redis_web_manager/info'
require 'redis_web_manager/data'
require 'redis'

module RedisWebManager
  class << self
    # FIXME: check mattr_accessor
    mattr_accessor :redis, default: ::Redis.new
    mattr_accessor :authenticate, default: nil
    mattr_accessor :lifespan, default: 30.days

    def configure
      yield self
    end

    def info
      RedisWebManager::Info.new
    end

    def connection
      RedisWebManager::Connection.new
    end

    def action
      RedisWebManager::Action.new
    end

    def data
      RedisWebManager::Data.new
    end
  end
end
