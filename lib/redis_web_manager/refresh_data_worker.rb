# frozen_string_literal: true

module RedisWebManager
  class RefreshDataWorker < Base
    def perform
      insert_data
      flush_old_data
    end

    def insert_data
      redis.set("mykey", data)
    end

    def data
      # FIXME: Send this data as a concated string
      RedisWebManager::Info.new.stringified_infos
    end

    def interval
      Configuration.new.interval
    end

    def flush_old_data
      # Delete the oldest data according to the insertion date
    end
  end
end