# frozen_string_literal: true

RedisWebManager::Engine.routes.draw do
  # Configuration
  get '/clients', to: 'clients#index'

  # Configuration
  get '/configuration', to: 'configuration#index'

  # Actions
  delete '/flushdb', to: 'dashboard#flushdb'

  # Root
  root 'dashboard#index'
end
