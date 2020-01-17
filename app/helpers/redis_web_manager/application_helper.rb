# frozen_string_literal: true

module RedisWebManager
  module ApplicationHelper
    def status(value)
      if value
        content_tag(:span, 'ON', class: 'badge badge-pill badge-success')
      else
        content_tag(:span, 'OFF', class: 'badge badge-pill badge-danger')
      end
    end
  end
end
