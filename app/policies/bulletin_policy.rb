# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def new?
    user
  end

  def edit?
    author?
  end

  def create?
    user
  end

  def update?
    author?
  end

  def to_moderate?
    author?
  end

  def archive?
    author?
  end

  private

  def author?
    record.user == user
  end
end
