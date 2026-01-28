class CreateDailyHabits < ActiveRecord::Migration[7.2]
  def change
    create_table :daily_habits do |t|
      t.references :user, null: false, foreign_key: true
      t.references :global_habit, foreign_key: true
      t.string :title, null: false
      t.date :date, null: false
      t.boolean :completed, default: false
      t.boolean :skipped, default: false

      t.timestamps
    end

    add_index :daily_habits, [:user_id, :date]
  end
end
