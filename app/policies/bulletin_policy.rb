# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def show?
    published? || author? || admin?
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

  def admin?
    user&.admin?
  end

  def published?
    record.published?
  end
end
