class DailyHabit < ApplicationRecord
  belongs_to :user
  belongs_to :global_habit, optional: true

  validates :title, :date, presence: true, if: :custom_habit?

  def custom_habit?
    global_habit_id.nil?
  end
end
