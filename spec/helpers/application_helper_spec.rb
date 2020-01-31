# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RedisWebManager::ApplicationHelper, type: :helper do
  describe 'helper' do
    it 'returns status tag (true)' do
      expect(helper.status(true)).to match(/ON/)
    end

    it 'returns status tag (true)' do
      expect(helper.status(false)).to match(/OFF/)
    end

    it 'returns url tag' do
      expect(helper.url('test.com')).to match(/kbd/)
    end
  end
end