# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RedisWebManager do
  describe 'Test default configuration' do
    it 'returns a Redis class' do
      expect(RedisWebManager.redis).to be_a_kind_of(Redis)
    end

    it 'returns a nil class' do
      expect(RedisWebManager.authenticate).to eql(nil)
    end

    it 'returns a ActiveSupport::Duration class' do
      expect(RedisWebManager.lifespan).to be_a_kind_of(ActiveSupport::Duration)
    end
  end

  describe 'Test new configuration' do
    it 'returns a raise error (Redis)' do
      expect do
        RedisWebManager.configure do |c|
          c.redis = 1
        end
      end.to raise_error(ArgumentError)
    end

    it 'returns a raise error (lifespan)' do
      expect do
        RedisWebManager.configure do |c|
          c.lifespan = 1
        end
      end.to raise_error(ArgumentError)
    end
  end
end
