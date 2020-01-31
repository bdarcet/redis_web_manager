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
    mattr_accessor :lifespan, default: 30.days

    class << self

      def configure
        yield self if block_given?
        check_attrs
      end

      private

      def check_attrs
        # FIXME: add better message
        unless redis.kind_of?(::Redis)
          raise ArgumentError ""
        end

        unless lifespan.kind_of?(ActiveSupport::Duration)
          raise ArgumentError ""
        end
      end
    end
end
