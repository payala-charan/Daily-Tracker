class CreateExpenses < ActiveRecord::Migration[7.2]
  def change
    create_table :expenses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :category
      t.decimal :amount

      t.timestamps
    end
  end
end
