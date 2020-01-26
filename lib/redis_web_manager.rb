# frozen_string_literal: true

require 'redis_web_manager/engine'
require 'redis_web_manager/base'
require 'redis_web_manager/action'
require 'redis_web_manager/configuration'
require 'redis_web_manager/connection'
require 'redis_web_manager/info'
require 'redis_web_manager/stat'
require 'redis_web_manager/stats/client'
require 'redis_web_manager/stats/command'
require 'redis_web_manager/stats/latency'
require 'redis_web_manager/stats/memory'

module RedisWebManager
  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
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
  end
end
