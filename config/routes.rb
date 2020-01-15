# frozen_string_literal: true

RedisWebManager::Engine.routes.draw do
  # Root
  root 'dashboard#index'
end
