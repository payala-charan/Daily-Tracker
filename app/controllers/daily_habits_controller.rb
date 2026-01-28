class DailyHabitsController < ApplicationController
  before_action :set_daily_habit, only: [:edit, :update, :destroy]
  def index
    @date = params[:date]&.to_date || Date.current
    # 1️⃣ ACTIVE global habits
    @global_habits = current_user.global_habits.where(active: true)
    # 2️⃣ Existing daily habits for that date
    @daily_habits = current_user.daily_habits.where(date: @date)
    # 3️⃣ Create missing daily habits automatically
    @global_habits.each do |gh|
      @daily_habits.find_or_create_by!(
        global_habit_id: gh.id,
        user_id: current_user.id,
        date: @date
      ) do |dh|
        dh.completed = false
      end
    end
    @daily_habits = current_user.daily_habits.where(date: @date)
  end

  def new
    @habit = current_user.daily_habits.new
    @date = params[:date]
  end

  def create
    @daily_habit = current_user.daily_habits.new(daily_habit_params)
    if @daily_habit.save
      redirect_to habits_dashboard_path(date: @daily_habit.date)
    else
      @global_habits = current_user.global_habits.where(active: true)
      render :new
    end
  end

  def update
    @daily_habit = current_user.daily_habits.find(params[:id])

    if @daily_habit.update(daily_habit_params)
      redirect_to daily_habits_path(date: @daily_habit.date),
                  notice: "Habit updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @daily_habit.global_habit_id.present?
      redirect_back fallback_location: daily_habits_path,
                    alert: "Global habits cannot be deleted here"
      return
    end

    date = @daily_habit.date
    @daily_habit.destroy

    redirect_to daily_habits_path(date: date),
                notice: "Habit deleted"
  end


  private

  def daily_habit_params
    params.require(:daily_habit).permit(
      :title, :date, :completed, :global_habit_id
    )
  end

  def set_daily_habit
    @daily_habit = current_user.daily_habits.find_by(id: params[:id])

    unless @daily_habit
      redirect_back fallback_location: daily_habits_path,
                    alert: "Habit not found"
    end
  end
end
