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
        @informations << { name: key, info: instance_variable_set("@#{key}", RedisWebManager::Base.new.info[value]) }
      end
      @status = RedisWebManager::Base.new.status
      @dbsize = RedisWebManager::Base.new.dbsize
    end
  end
end
