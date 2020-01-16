# frozen_string_literal: true

module RedisWebManager
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :authenticate!

    private

    def authenticate!
      if authenticate || !defined?(super)
        instance_exec(&authenticate)
      else
        super
      end
    end

    def authenticate
      RedisWebManager.configuration.authenticate
    end
  end
end
