# frozen_string_literal: true

module RedisWebManager
  class ConfigurationController < ApplicationController
    def index
      @configurations = RedisWebManager.info.configuration
    end
  end
end