# frozen_string_literal: true

module RedisWebManager
  class DashboardController < ApplicationController
    def index
      #@version = RedisWebManager::Base.new.info['redis_version']
      @status = RedisWebManager::Base.new.status
    end
  end
end
