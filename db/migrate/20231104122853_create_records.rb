# frozen_string_literal: true

class CreateRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :records do |t|
      t.date :date, null: false
      t.integer :quantity, null: false
      t.references :drink, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
