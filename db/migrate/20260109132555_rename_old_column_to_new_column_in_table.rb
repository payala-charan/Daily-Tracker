class RenameOldColumnToNewColumnInTable < ActiveRecord::Migration[7.2]
  def change
    rename_column :notes, :user, :note
  end
end
