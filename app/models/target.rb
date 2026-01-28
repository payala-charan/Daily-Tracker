class Target < ApplicationRecord
  belongs_to :user

  validates :target_name, :target_date, presence: true

  # Total days from creation to target date
  def total_days
    (target_date - created_at.to_date).to_i
  end

  # Days left from today to target date
  def days_left
    (target_date - Date.today).to_i
  end

  def total_seconds
    (target_date.to_time - created_at).to_i
  end

  def seconds_left
    (target_date.to_time - Time.current).to_i
  end

  # Progress percentage (0 → 100)
  def progress_percentage
    return 100 if days_left <= 0
    return 0 if total_days <= 0

    passed_days = total_days - days_left
    ((passed_days.to_f / total_days) * 100).round

    used_seconds = total_seconds - seconds_left
    ((used_seconds.to_f / total_seconds) * 100).round
  end
end
