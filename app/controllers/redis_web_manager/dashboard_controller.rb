# frozen_string_literal: true

module RedisWebManager
  class DashboardController < ApplicationController
    INFORMATIONS = { version: 'redis_version',
                     role: 'role',
                     uptime_in_days: 'uptime_in_days',
                     used_memory: 'used_memory_human',
                     used_memory_peak_human: 'used_memory_peak_human',
                     mem_fragmentation_ratio: 'mem_fragmentation_ratio' }.freeze

    def index
      @informations = []
      INFORMATIONS.each do |key, value|
        @informations << { name: key, info: RedisWebManager.info[value] }
      end
      @status = RedisWebManager.info.status
      @dbsize = RedisWebManager.info.dbsize
    end
  end
end