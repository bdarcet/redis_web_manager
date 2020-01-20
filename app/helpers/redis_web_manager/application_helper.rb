# frozen_string_literal: true

module RedisWebManager
  module ApplicationHelper
    def status(value)
      if value
        content_tag(:kbd, 'Status: ON', class: 'bg-success')
      else
        content_tag(:kbd, 'Status: OFF', class: 'bg-danger')
      end
    end

    def url(value)
      content_tag(:kbd, "URL: #{value}", class: 'bg-dark')
    end

    def last_save(value)
      content_tag(:kbd, "Last save: #{value.strftime('%F - %R')}", class: 'bg-secondary')
    end

    def keys(value)
      content_tag(:kbd, "Keys: #{value}", class: 'bg-info')
    end
  end
end
