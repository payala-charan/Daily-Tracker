class GlobalHabit < ApplicationRecord
  belongs_to :user
  has_many :daily_habits, dependent: :destroy

  validates :title, presence: true
end
