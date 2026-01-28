class Habit < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :date, presence: true

  scope :for_date, ->(date) { where(date: date) }
  scope :completed, -> { where(completed: true) }
  scope :incomplete, -> { where(completed: false) }
  scope :ordered, -> { order(date: :desc) }
  def streak
    days = 0
    expected_date = Date.today

    habits = user.habits
                 .where(title: title, completed: true)
                 .order(date: :desc)

    habits.each do |habit|
      if habit.date == expected_date
        days += 1
        expected_date -= 1.day
      else
        break
      end
    end

    days
  end
end
