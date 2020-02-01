# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RedisWebManager::Action do
  let(:action) do
    RedisWebManager::Action.new
  end

  describe 'action' do
    it 'returns a OK (flushall)' do
      expect(action.flushall).to eql('OK')
    end

    it 'returns a OK (flushdb)' do
      expect(action.flushdb).to eql('OK')
    end

    it 'returns a 1 (del)' do
      redis = Redis.new
      redis.set('test', 'test')
      expect(action.del('test')).to eql(1)
    end

    it 'returns a OK (rename)' do
      redis = Redis.new
      redis.set('test', 'test')
      expect(action.rename('test', 'test2')).to eql('OK')
    end
  end
end
