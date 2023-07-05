# frozen_string_literal: true

# == Schema Information
#
# Table name: bulletins
#
#  id          :integer          not null, primary key
#  aasm_state  :string
#  description :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer          not null
#  user_id     :integer          not null
#
# Indexes
#
#  index_bulletins_on_category_id  (category_id)
#  index_bulletins_on_user_id      (user_id)
#
# Foreign Keys
#
#  category_id  (category_id => categories.id)
#  user_id      (user_id => users.id)
#
class Bulletin < ApplicationRecord
  include AASM

  aasm do
    state :draft, initial: true
    state :under_moderation
    state :published
    state :rejected
    state :archived

    event :send_to_moderate do
      transitions from: :draft, to: :under_moderation
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end

    event :archive do
      transitions to: :archived
    end
  end

  has_one_attached :image

  belongs_to :category
  belongs_to :user

  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 3, maximum: 1000 }
  validates :image, attached: true, content_type: %i[png jpg jpeg], size: { less_than: 5.megabytes }

  def self.ransackable_attributes(_auth_object = nil)
    %w[title category_id aasm_state]
  end
end
