# frozen_string_literal: true

module ApplicationHelper
  include AuthConcern

  def nav_link(anchor, url)
    link_to anchor, url, class: class_names('nav-link', active: current_page?(url))
  end
end
