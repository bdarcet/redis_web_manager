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

    # FIXME: Error when we call the method.
    def memory_usage
      @memory_usage ||= redis.memory(:usage)
    end

    def last_save
      @last_save ||= Time.at(redis.lastsave)
    end

    # FIXME: Olivier, Add Memory usage once it's fixed. memoryusage:#{memory_usage}
    def stringify_infos
      "#{DateTime.now}_status:#{status}_stats:#{stats}_dbsize:#{dbsize}_configuration:#{configuration}_latency:#{latency}_lastsave:#{last_save}"
    end
    
    def clients
      @clients ||= redis.client(:list)
    end
  end
end
