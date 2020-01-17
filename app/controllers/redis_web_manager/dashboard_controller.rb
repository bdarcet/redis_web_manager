# frozen_string_literal: true

module RedisWebManager
  class DashboardController < ApplicationController
    def index
      @informations = stats.map { |k, v| { name: k.to_s.humanize, value: v } }
      @status = info.status
      @dbsize = info.dbsize
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

    def stats
      @stats ||= info.stats.symbolize_keys.slice(:redis_version,
                                                 :redis_mode,
                                                 :os,
                                                 :role,
                                                 :connected_clients,
                                                 :uptime_in_days,
                                                 :uptime_in_seconds,
                                                 :used_memory_human,
                                                 :used_memory_peak_human,
                                                 :mem_fragmentation_ratio)
    end
  end
end
