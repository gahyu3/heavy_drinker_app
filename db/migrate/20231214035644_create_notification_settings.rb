class CreateNotificationSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :notification_settings do |t|
      t.boolean :day, default: true
      t.boolean :week, default: true
      t.boolean :month, default: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
