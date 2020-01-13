# frozen_string_literal: true

require 'redis_web_manager/engine'
require 'redis_web_manager/configuration'

module RedisWebManager
  class << self
    attr_writer :configuration

    def lol
      puts 'lol'
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
