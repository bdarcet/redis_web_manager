# frozen_string_literal: true

require 'redis'

module RedisWebManager
  class Configuration
    attr_accessor :redis, :authenticate, :insertion_interval, :keys_to_save

    # FIXME: Allow the user to set the @insertion_interval and @keys_to_save
    def initialize
      @redis = ::Redis.new
      @authenticate = nil
      @insertion_interval = 1
      @keys_to_save = 30
    end
  end
end
