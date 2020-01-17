# frozen_string_literal: true

module RedisWebManager
  class ConfigurationController < ApplicationController
    def index
      @configurations = info.configuration
      @status = info.status
    end

    private

    def info
      @info ||= RedisWebManager.info
    end
  end
end