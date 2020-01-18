# frozen_string_literal: true

module RedisWebManager
  class ConfigurationController < ApplicationController
    def index
      @configurations = info.configuration
      # FIXME: Move status + name
      @status = info.status
      @name = connection.id
    end

    private

    def info
      @info ||= RedisWebManager.info
    end

    def connection
      @connection ||= RedisWebManager.connection
    end
  end
end