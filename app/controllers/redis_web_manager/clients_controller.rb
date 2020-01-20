# frozen_string_literal: true

module RedisWebManager
  class ClientsController < ApplicationController
    # GET /client
    def index
      @status = info.status
      @url = connection.id
      @clients = info.clients.map(&:symbolize_keys) # FIXME: Improve design
    end

    private

    def info
      @info ||= RedisWebManager.info
    end

    def connection
      @connection ||= RedisWebManager.connection
    end
  end
end