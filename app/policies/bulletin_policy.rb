# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def new?
    user
  end

  def create?
    user
  end
end
