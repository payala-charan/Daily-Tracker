class CreateUploadedFiles < ActiveRecord::Migration[7.2]
  def change
    create_table :uploaded_files do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :file_type
      t.integer :file_size

      t.timestamps
    end
  end
end
