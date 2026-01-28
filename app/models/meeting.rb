class Meeting < ApplicationRecord
  belongs_to :user
  before_save :remove_blank_participants
  def remove_blank_participants
    self.participants = participants.reject(&:blank?)
  end
end
