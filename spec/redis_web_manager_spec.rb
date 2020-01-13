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
  end
end