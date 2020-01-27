# frozen_string_literal: true

module RedisWebManager
  class Data < Base
    BASE = 'RedisWebManager'

    def keys
      data.map { |key| JSON.parse(redis.get(key)) }
    end

    def perform
      flush_old_data
      insert_data
    end

    private

    def insert_data
      timestamp = Time.now.to_time.to_i
      redis.set("#{BASE}_#{timestamp}", serialize.to_json)
    end

    def flush_old_data
      data.each do |key|
        tmp = format_key(key)
        next if tmp.nil?
        time = Time.at(tmp.to_i)
        time_lifespan = Time.now + lifespan.days
        redis.del(key) if time > time_lifespan
      end
    end

    def data
      @data ||= redis.scan_each(match: "#{BASE}_*").to_a
    end

    def lifespan
      @lifespan ||= RedisWebManager.configuration.lifespan
    end

    def format_key(key)
      key.tr("#{BASE}_", '')
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
        used_memory_peak_perc: format_percentage(stats[:used_memory_peak_perc]),
        used_memory_overhead: stats[:used_memory_overhead],
        used_memory_startup: stats[:used_memory_startup],
        used_memory_dataset: stats[:used_memory_dataset],
        used_memory_dataset_perc: format_percentage(stats[:used_memory_dataset_perc])
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

    def format_percentage(value)
      value.tr('%', '')
    end
  end
end
