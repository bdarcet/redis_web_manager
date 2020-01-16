# frozen_string_literal: true

module RedisWebManager
  class DashboardController < ApplicationController
    INFORMATIONS = { version: 'redis_version',
                     role: 'role',
                     used_memory: 'used_memory_human',
                     total_system_memory: 'total_system_memory_human' }.freeze

    def index
      INFORMATIONS.each do |key, value|
        instance_variable_set("@#{key}", RedisWebManager::Base.new.info[value])
      end
      @status = RedisWebManager::Base.new.status
    end
  end
end
