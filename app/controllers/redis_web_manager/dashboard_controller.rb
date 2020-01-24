# frozen_string_literal: true

module RedisWebManager
  class DashboardController < ApplicationController
    # GET /dashboard
    def index
      @information = stats.map { |k, v| { name: k.to_s.humanize, value: v } }
      @status = info.status
      @url = connection.id
      @memory_usage_data = MemoryUsageService.new.data
    end

    private

    def info
      @info ||= RedisWebManager.info
    end

    def connection
      @connection ||= RedisWebManager.connection
    end

    def stats
      @stats ||= info.stats.symbolize_keys.slice(:redis_version,
                                                 :redis_mode,
                                                 :os,
                                                 :role,
                                                 :config_file,
                                                 :connected_clients,
                                                 :blocked_clients,
                                                 :uptime_in_days)
    end
  end
end
