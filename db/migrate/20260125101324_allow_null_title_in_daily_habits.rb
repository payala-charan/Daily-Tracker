class AllowNullTitleInDailyHabits < ActiveRecord::Migration[7.2]
  def change
    change_column_null :daily_habits, :title, true
  end
end
