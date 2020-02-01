# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RedisWebManager::Info do
  let(:info) do
    RedisWebManager::Info.new
  end

  describe 'info' do
    it 'returns a true (status)' do
      expect(info.status).to eql(true)
    end

    it 'returns a Hash class (stats)' do
      expect(info.stats).to be_a_kind_of(Hash)
    end

    it 'returns a Array class (keys)' do
      expect(info.keys).to be_a_kind_of(Array)
    end

    it 'returns a Integer class (dbsize)' do
      expect(info.dbsize).to be_a_kind_of(Integer)
    end

    it 'returns a Hash class (configuration)' do
      expect(info.configuration).to be_a_kind_of(Hash)
    end

    it 'returns a Array class (clients)' do
      expect(info.clients).to be_a_kind_of(Array)
    end
  end
end
