# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RedisWebManager do
  describe 'Test configuration' do
    it 'returns a Redis class' do
      expect(RedisWebManager.configuration.redis).to be_a_kind_of(Redis)
    end

    it 'returns a Redis class (Reset)' do
      RedisWebManager.reset
      expect(RedisWebManager.configuration.redis).to be_a_kind_of(Redis)
    end

    it 'returns a valid db' do
      RedisWebManager.configure do |config|
        config.redis = Redis.new(db: 1)
      end
      expect(RedisWebManager.configuration.redis.connection[:db]).to eql(1)
    end

    it 'returns a raise error' do
      expect do
        RedisWebManager.configure do |config|
          config.redis = 'Test'
        end
      end.to raise_error(ArgumentError)
    end
  end
end
