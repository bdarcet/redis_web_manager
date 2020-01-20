# frozen_string_literal: true

RedisWebManager::Engine.routes.draw do
  # Configuration
  get '/configuration', to: 'configuration#index'

  # Clients
  get '/clients', to: 'clients#index'

  # Actions
  delete '/flushdb', to: 'dashboard#flushdb'

  # Root
  root 'dashboard#index'
end
