# frozen_string_literal: true

module RedisWebManager
  class DashboardController < ApplicationController
    def index
      #@version = RedisWebManager::Base.new.info['redis_version']
    end
  end
end
