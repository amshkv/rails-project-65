# frozen_string_literal: true

class AddAdminRoleToMe < ActiveRecord::Migration[7.0]
  def change
    User.find_by(email: 'fakesupp@gmail.com')&.update!(admin: true)
  end
end
