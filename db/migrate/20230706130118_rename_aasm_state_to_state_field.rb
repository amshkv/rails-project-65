# frozen_string_literal: true

class RenameAasmStateToStateField < ActiveRecord::Migration[7.0]
  def change
    rename_column :bulletins, :aasm_state, :state
  end
end
