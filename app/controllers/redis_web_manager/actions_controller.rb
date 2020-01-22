# frozen_string_literal: true

module RedisWebManager
  class ActionsController < ApplicationController
    # DELETE /flushdb
    def flushdb
      command.flushdb
      redirect_to root_path
    end

    # DELETE /flushall
    def flushall
      command.flushall
      redirect_to root_path
    end

    private

    def command
      @command ||= RedisWebManager.command
    end
  end
end