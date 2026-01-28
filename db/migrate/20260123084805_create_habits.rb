class CreateHabits < ActiveRecord::Migration[7.2]
  def change
    create_table :habits do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.date :date, null: false
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
