# frozen_string_literal: true
require 'multi_json'

module RedisWebManager
  class KeysController < ApplicationController
    # FIXME : REFACTO CONTROLLER + VIEW + Pagination
    def index
      info_keys = info.keys
      @keys = info_keys.map.with_index { |key, index| format_key(key, index) }
      @types = info_keys.map { |key| info.type(key) }.uniq!
      @status = info.status
      @url = connection.id
    end

    def show
      @key = format_key(params[:key], 0)
    end

    def edit
      @key = format_key(params[:key], 0)
    end

    def update
      redirect_to root_path if params[:key].nil? || params[:old_key].nil?
      command.rename(params[:old_key], params[:key])
      redirect_to keys_path
    end

    def destroy
      redirect_to root_path if params[:key].nil?
      command.destroy_key(params[:key])
      redirect_to keys_path
    end

    private

    def info
      @info ||= RedisWebManager.info
    end

    def command
      @command ||= RedisWebManager.command
    end

    def connection
      @connection ||= RedisWebManager.connection
    end

    def item_type(e)
      begin
        ['json', MultiJson.decode(e)]
      rescue MultiJson::LoadError
        ['string', e]
      end
    end

    # Get values for Redis List type
    def get_list(key, opts = {})
      start = opts[:start] ? opts[:start].to_i : 0
      stop  = opts[:stop] ? opts[:stop].to_i : 99

      length = info.llen(key)
      values = info.lrange(key, start, stop).map.with_index do |e, i|
        type, value = item_type(e)
        { type: type, value: value, index: start + i }
      end

      { length: length, values: values }
    end

    # Get values for Redis Set type
    def get_set(key)
      info.smembers(key).map do |e|
        type, value = item_type(e)
        { type: type, value: value }
      end
    end

    # Get values for Redis Zset type
    def get_zset(key)
      info.zrange(key, 0, -1, withscores: true).map do |e, score|
        type, value = item_type(e)
        { type: type, value: value, score: score }
      end
    end

    # Get values for Redis Hash type
    def get_hash(key)
      Hash[info.hgetall(key).map do |k,v|
        type, value = item_type(v)
        [k, { type: type, value: value }]
      end]
    end

    def get_value(key, opts = {})
      type = info.type(key)
      case type
      when 'string'
        info.get(key)
      when 'list'
        get_list(key, opts)
      when 'set'
        get_set(key)
      when 'zset'
        get_zset(key)
      when 'hash'
        get_hash(key)
      else
        'Not found'
      end
    end

    def format_key(key, idx)
      {
        id: idx,
        key: key,
        value: get_value(key),
        type: info.type(key),
        size: info.key_memory_usage(key),
        expire_at: ''
      }
    end
  end
end