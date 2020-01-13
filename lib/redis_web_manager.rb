# frozen_string_literal: true

require 'redis_web_manager/configuration'
require 'redis_web_manager/engine'

module RedisWebManager
  class << self
    attr_writer :configuration
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
