# frozen_string_literal: true

class AddAdminToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :admin, :boolean, null: false, default: false # TODO: дефолт в базе, зло жеж?
    # https://github.com/Hexlet/hexlet-slack-archive/wiki/Проблемы-дефолтных-значений-в-БД
  end
end
