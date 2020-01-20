# frozen_string_literal: true

module RedisWebManager
  class Client < Base

    # GET /clients
    def clients
      @clients ||= redis.client(:list)
    end
  end
end