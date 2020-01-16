# frozen_string_literal: true

module RedisWebManager
  class DashboardController < ApplicationController
    def index
      @status = RedisWebManager::Base.new.status
    end
  end
end
