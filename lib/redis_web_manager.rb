# frozen_string_literal: true

require 'redis_web_manager/engine'
require 'redis_web_manager/configuration'
require 'redis_web_manager/redis_cli'

module RedisWebManager
  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def reset
      @configuration = Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
