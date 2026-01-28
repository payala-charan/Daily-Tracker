class ChangeParticipantsToArrayInMeetings < ActiveRecord::Migration[7.2]
  def up
    remove_column :meetings, :participants
    add_column :meetings, :participants, :text, array: true, default: []
  end

  def down
    remove_column :meetings, :participants
    add_column :meetings, :participants, :text
  end
end
