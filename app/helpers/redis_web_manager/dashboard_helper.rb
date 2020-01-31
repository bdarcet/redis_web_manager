# frozen_string_literal: true

module RedisWebManager
  module DashboardHelper
    def graph_canvas(data)
      if data.empty?
        # FIXME: Put the link of the doc where we explain how to call the perform method from data.rb.
        content_tag(:div, 'You don\'t have any RedisWebManager keys yet into your redis database.', class:'m-5 text-center')
      else
        id = data[1].keys[1].to_s
        content_tag(:canvas, '', id: id, width: 800, height: 400, data: { canvas: data.to_json })
      end
    end
  end
end