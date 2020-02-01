# frozen_string_literal: true

require 'multi_json'
require 'pagy'
require 'pagy/extras/array'
require 'pagy/extras/bootstrap'

module RedisWebManager
  class KeysController < ApplicationController
    include ::Pagy::Backend

    def index
      # Keys
      @keys = info.keys.map { |key, index| format_key(key, index) }.sort { |a, b| a[:key] <=> b[:key] }

      # Status & Url
      @status = info.status
      @url = connection.id

      # Pagination
      @pagy, @keys = pagy_array(@keys)
    end

    def show
      @key = format_key(params[:key], 0)
    end

    def edit
      @key = format_key(params[:key], 0)
    end

    def update
      old_key = params[:old_name].presence
      new_name = params[:new_name].presence
      redirect_to root_path if old_key.nil? || new_name.nil?
      action.rename(old_key, new_name)
      redirect_to keys_url
    end

    def destroy
      key = params[:key].presence
      redirect_to root_path if key.nil?
      action.del(key)
      redirect_to keys_url
    end

    private

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
      values = info.smembers(key).map do |e|
        type, value = item_type(e)
        { type: type, value: value }
      end

      { values: values }
    end

    # Get values for Redis Zset type
    def get_zset(key)
      values = info.zrange(key, 0, -1, withscores: true).map do |e, score|
        type, value = item_type(e)
        { type: type, value: value, score: score }
      end

      { values: values }
    end

    # Get values for Redis Hash type
    def get_hash(key)
      value = Hash[info.hgetall(key).map do |k,v|
        type, value = item_type(v)
        [k, { type: type, value: value }]
      end]

      { value: value }
    end

    def get_value(key, opts = {})
      type = info.type(key)
      case type
      when 'string'
        { value: info.get(key) }
      when 'list'
        get_list(key, opts)
      when 'set'
        get_set(key)
      when 'zset'
        get_zset(key)
      when 'hash'
        get_hash(key)
      else
        { value: 'Not found' }
      end
    end

    def format_key(key, idx)
      {
        id: idx,
        key: key,
        expire: info.expire(key),
        value: get_value(key),
        type: info.type(key),
        memory: info.key_memory_usage(key)
      }
    end
  end
end