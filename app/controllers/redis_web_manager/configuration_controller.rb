# frozen_string_literal: true

module RedisWebManager
  class ConfigurationController < ApplicationController
    # GET /configuration
    def index
      @configurations = info.configuration
      @status = info.status
      @dbsize = info.dbsize
      @last_save = info.last_save
      @url = connection.id
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