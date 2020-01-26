# frozen_string_literal: true

module RedisWebManager
  class Data < Base
    private

    def insert_data
      redis.set("RedisWebManager_#{Time.now}", serialize.to_s)
    end

    def flush_old_data
      redis_web_manager_keys.each_with_index do |key, index|
        index >= keys_to_save ? redis.del(key) : nil
      end
    end

    def keys_to_save
      @keys_to_save ||= RedisWebManager.configuration.lifespan
    end

    # use this interval to trigger the job
    def insertion_interval
      @insertion_interval ||= RedisWebManager.configuration.interval
    end

    def redis_web_manager_keys
      @redis_web_manager_keys ||= Info.new.redis_web_manager_keys
    end

    def serialize
      {
          date: Time.now,
          memory: memory,
          client: client,
          cpu: cpu
      }
    end

    def memory
      {
        used_memory: stats[:used_memory],
        used_memory_rss: stats[:used_memory_rss],
        used_memory_peak: stats[:used_memory_peak],
        used_memory_peak_perc: stats[:used_memory_peak_perc],
        used_memory_overhead: stats[:used_memory_overhead],
        used_memory_startup: stats[:used_memory_startup],
        used_memory_dataset: stats[:used_memory_dataset],
        used_memory_dataset_perc: stats[:used_memory_dataset_perc]
      }
    end

    def client
      {
        connected_clients: stats[:connected_clients],
        blocked_clients: stats[:blocked_clients]
      }
    end

    def cpu
      {
        used_cpu_sys: stats[:used_cpu_sys],
        used_cpu_user: stats[:used_cpu_user],
        used_cpu_sys_children: stats[:used_cpu_sys_children],
        used_cpu_user_children: stats[:used_cpu_user_children]
      }
    end

    def stats
      @stats ||= redis.info.symbolize_keys
    end
  end
end
