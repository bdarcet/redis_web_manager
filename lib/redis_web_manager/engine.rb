# frozen_string_literal: true

module RedisWebManager
  class Engine < ::Rails::Engine
    isolate_namespace RedisWebManager
  end
end
