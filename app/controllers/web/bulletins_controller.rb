# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  def index
    @bulletins = Bulletin.all
  end
end
