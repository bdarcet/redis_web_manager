# frozen_string_literal: true

module RedisWebManager
  class RefreshDataWorker < Base
    def perform
      insert_data
      flush_old_data if redis_web_manager_keys.size >= keys_to_save
    end

    private

    def insert_data
      key = "RedisWebManager_#{DateTime.now}"
      redis.set(key, infos_to_save)
    end

    def flush_old_data
      redis_web_manager_keys.each_with_index do |data_key, index|
        index >= keys_to_save ? redis.del(data_key) : nil
      end
    end

    def keys_to_save
      @keys_to_save ||= Configuration.new.keys_to_save
    end

    def infos_to_save
      @infos_to_save ||= RedisWebManager::Info.new.infos_to_save
    end

    # use this interval to trigger the job
    def insertion_interval
      @insertion_interval ||= Configuration.new.insertion_interval
    end

    def redis_web_manager_keys
      @redis_web_manager_keys ||= Info.new.redis_web_manager_keys
    end
  end
end