# frozen_string_literal: true

module RedisWebManager
  class RefreshDataWorker < Base
    def perform
      insert_data
      flush_old_data if data_keys.size >= keys_to_save
    end

    private

    def insert_data
      key = "RedisWebManager_#{DateTime.now}"
      redis.set(key, data)
    end

    def flush_old_data
      data_keys.each_with_index do |data_key, index|
        index >= keys_to_save ? redis.del(data_key) : nil
      end
    end

    def keys_to_save
      @keys_to_save ||= Configuration.new.keys_to_save
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