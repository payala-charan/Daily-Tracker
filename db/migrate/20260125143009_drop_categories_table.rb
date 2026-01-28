class DropCategoriesTable < ActiveRecord::Migration[7.2]
  def change
    drop_table :categories, force: :cascade
  end
end