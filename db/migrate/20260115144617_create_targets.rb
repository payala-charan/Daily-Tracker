class CreateTargets < ActiveRecord::Migration[7.2]
  def change
    create_table :targets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :target_name
      t.date :target_date
      t.text :description

      t.timestamps
    end
  end
end
