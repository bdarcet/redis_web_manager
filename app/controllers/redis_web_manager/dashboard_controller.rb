# frozen_string_literal: true

module RedisWebManager
  class DashboardController < ApplicationController
    def index
      @information = stats.map { |k, v| { name: k.to_s.humanize, value: v } }
      # FIXME: Move status + url
      @status = info.status
      @url = connection.id
    end

    def flushdb
      command.flushdb
      redirect_to root_path
    end

    private

    def info
      @info ||= RedisWebManager.info
    end

    def command
      @command ||= RedisWebManager.command
    end

    def connection
      @connection ||= RedisWebManager.connection
    end

    def stats
      @stats ||= info.stats.symbolize_keys.slice(:redis_version,
                                                 :redis_mode,
                                                 :os,
                                                 :role,
                                                 :connected_clients,
                                                 :uptime_in_days,
                                                 :used_memory_human,
                                                 :used_memory_peak_human,
                                                 :mem_fragmentation_ratio)
    end
  end
end
