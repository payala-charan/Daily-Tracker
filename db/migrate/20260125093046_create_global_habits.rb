class CreateGlobalHabits < ActiveRecord::Migration[7.2]
  def change
    create_table :global_habits do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
