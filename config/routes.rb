# frozen_string_literal: true

RedisWebManager::Engine.routes.draw do
  # Root
  root 'dashboard#index'
  # Configuration
  get '/configuration', to: 'configuration#index'

  # Actions
  # -------
  # Flush
  delete '/flushdb', to: 'dashboard#flushdb'
  # Pause
  get '/pause', to: 'dashboard#pause'
end
