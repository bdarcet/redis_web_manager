# frozen_string_literal: true

module RedisWebManager
  class RefreshDataWorker < Base
    def perform
      insert_data
      # FIXME: Olivier, only flush the data when the keys number reach the key number set by the user in the config.
      # data_keys.size == Configuration.new
      # If data_keys.size == Configuration.new.user_keys then flush else dont flush and keep saving the keys.
      # flush_old_data
    end

    private

    def insert_data
      key = "RedisWebManager_#{DateTime.now}"
      redis.set(key, data)
    end

    def flush_old_data
      oldest_data = data_keys
      redis.del(oldest_data)
    end

    def data
      @data ||= RedisWebManager::Info.new.stringify_infos
    end

    def insertion_interval
      @insertion_interval ||= Configuration.new.insertion_interval
    end

    def data_keys
      @data_keys ||= redis.keys.grep(/^RedisWebManager_/)
    end
  end
end