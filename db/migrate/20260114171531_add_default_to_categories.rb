class AddDefaultToCategories < ActiveRecord::Migration[7.2]
  def change
    add_column :categories, :default, :boolean
  end
end
