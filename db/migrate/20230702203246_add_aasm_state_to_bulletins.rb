# frozen_string_literal: true

class AddAasmStateToBulletins < ActiveRecord::Migration[7.0]
  def change
    add_column :bulletins, :aasm_state, :string
  end
end
