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
      # FIXME: Error when we call the method.
      @memory_usage ||= redis.memory(:usage)
    end

    def last_save
      @last_save ||= Time.at(redis.lastsave)
    end

    def stringify_infos
      # FIXME: Olivier, Add Memory usage once it's fixed. memoryusage:#{memory_usage}
      "#{DateTime.now}_status:#{status}_stats:#{stats}_dbsize:#{dbsize}_configuration:#{configuration}_latency:#{latency}_lastsave:#{last_save}"
    end
  end
end
