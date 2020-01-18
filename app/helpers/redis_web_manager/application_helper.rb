# frozen_string_literal: true

module RedisWebManager
  module ApplicationHelper
    def status(value)
      if value
        content_tag(:kbd, 'ON', class: 'bg-success bounce ml-1')
      else
        content_tag(:kbd, 'OFF', class: 'bg-danger bounce ml-1')
      end
    end

    def url(value)
      content_tag(:kbd, value)
    end
  end
end
