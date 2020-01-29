# frozen_string_literal: true

class MemoryUsageService
  # Attributes
  attr_reader :redis

  # Methods
  def initialize
    @redis = RedisWebManager.redis
  end

  def data
    redis_web_manager_keys = RedisWebManager::Info.new.redis_web_manager_keys
    redis_web_manager_keys.map! { |key| { key.tr('RedisWebManager_', '') => @redis.get(key) } }
  end
end