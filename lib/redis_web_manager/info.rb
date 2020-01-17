# frozen_string_literal: true

module RedisWebManager
  class Info < Base
    def status
      @status ||= redis.ping == 'PONG'
    end

    def stats
      @stats ||= redis.info
    end

    def dbsize
      @dbsize ||= redis.dbsize
    end

    def configuration
      @configuration ||= redis.config(:get, '*')
    end

    def latency
      @latency ||= redis.latency(:doctor)
    end

    def memory_usage
      @memory_usage ||= redis.memory(:usage)
    end

    def last_save
      @last_save ||= Time.at(redis.lastsave)
    end

    def stringified_infos
      # FIXME Do we need to add configuration here ? Whats inside ?
      "#{DateTime.now}_status:#{status}_stats:#{stats}_dbsize:#{dbsize}_configuration:#{configuration}_latency:#{latency}_memoryUsage:#{memory_usage}_lastsave:#{last_save}"
    end
  end
end
