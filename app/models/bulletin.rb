# frozen_string_literal: true

# == Schema Information
#
# Table name: bulletins
#
#  id          :integer          not null, primary key
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
  has_one_attached :image

  belongs_to :category
  belongs_to :user

  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 3, maximum: 1000 }
  validates :image, attached: true, content_type: %i[png jpg jpeg], size: { less_than: 5.megabytes }
end
