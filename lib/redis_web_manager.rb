# frozen_string_literal: true

require 'redis_web_manager/engine'
require 'redis_web_manager/configuration'
require 'redis_web_manager/base'
require 'redis_web_manager/command'
require 'redis_web_manager/connection'
require 'redis_web_manager/info'
require 'redis_web_manager/refresh_data_worker'

module RedisWebManager
  class << self
    # FIXME: Move configuration?
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

    def command
      RedisWebManager::Command.new
    end
  end
end
