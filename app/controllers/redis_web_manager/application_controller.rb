# frozen_string_literal: true

module RedisWebManager
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :authenticated?, if: :authenticate

    private

    def authenticated?
      instance_exec(&authenticate)
    end

    def authenticate
      RedisWebManager.authenticate
    end
  end
end
