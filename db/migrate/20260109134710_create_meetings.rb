class CreateMeetings < ActiveRecord::Migration[7.2]
  def change
    create_table :meetings do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.date :meeting_date
      t.time :meeting_time
      t.text :participants

      t.timestamps
    end
  end
end
