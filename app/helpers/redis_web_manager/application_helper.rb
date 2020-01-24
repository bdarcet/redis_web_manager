# frozen_string_literal: true

module RedisWebManager
  module ApplicationHelper
    def status(value)
      if value
        content_tag(:kbd, 'ON', class: 'bg-success bounce')
      else
        content_tag(:kbd, 'OFF', class: 'bg-danger bounce')
      end
    end

    def url(value)
      content_tag(:kbd, value, class: 'bg-dark')
    end
  end
end
