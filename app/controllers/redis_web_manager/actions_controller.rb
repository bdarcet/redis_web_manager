# frozen_string_literal: true

module RedisWebManager
  class ActionsController < ApplicationController
    # DELETE /flushdb
    def flushdb
      action.flushdb
      redirect_to root_path
    end

    # DELETE /flushall
    def flushall
      action.flushall
      redirect_to root_path
    end

    private

    def action
      @action ||= RedisWebManager.action
    end
  end
end