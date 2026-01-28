class CreateExpenditures < ActiveRecord::Migration[7.2]
  def change
    create_table :expenditures do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.decimal :amount

      t.timestamps
    end
  end
end
