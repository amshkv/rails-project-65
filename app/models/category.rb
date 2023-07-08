# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_categories_on_name  (name) UNIQUE
#
class Category < ApplicationRecord
  has_many :bulletins, dependent: :destroy
  validates :name, presence: true, length: { minimum: 3, maximum: 30 }, uniqueness: { case_sensitive: false }
end
