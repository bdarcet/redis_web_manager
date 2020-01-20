# frozen_string_literal: true

module RedisWebManager
  class ClientsController < ApplicationController
    # GET /client
    def clients
      @status = info.status
      @url = connection.id
    end
  end
end