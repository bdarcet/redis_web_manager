# frozen_string_literal: true
require 'multi_json'

module RedisWebManager
  class KeysController < ApplicationController
    # FIXME (BEN): REFACTO CTRLR + VIEW
    def index
      @status = info.status

      mkeys = info.keys
      @keys = []
      @types = []
      mkeys.each do |key, index|
        @types << info.type(key)
        @keys << format_key(key, index)
      end
      @types.uniq!
    end

    private

    def info
      @info ||= RedisWebManager.info
    end

    def item_type(e)
      begin
        ['json', MultiJson.decode(e)]
      rescue MultiJson::LoadError
        ['string', e]
      end
    end

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

    def get_set(key)
      values = info.smembers(key).map do |e|
        type, value = item_type(e)
        { type: type, value: value }
      end

      { values: values }
    end

    def get_zset(key)
      values = info.zrange(key, 0, -1, withscores: true).map do |e, score|
        type, value = item_type(e)
        { type: type, value: value, score: score }
      end

      { values: values }
    end

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
        value: get_value(key),
        type: info.type(key)
      }
    end
  end
end