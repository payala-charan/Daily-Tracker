class HabitsController < ApplicationController
  before_action :require_login
  before_action :set_habit, only: [:edit, :update, :destroy]

  def index
    @date = params[:date]&.to_date || Date.today
    @habits = current_user.habits.for_date(@date)
  end

  def new
    @habit = current_user.habits.new(date: Date.today)
  end

  def create
    @habit = current_user.habits.new(habit_params)

    if @habit.save
      redirect_to habits_path, notice: "Habit created!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @habit.update(habit_params)
      redirect_to habits_path, notice: "Habit updated!"
    else
      render :edit
    end
  end

  def destroy
    @habit.destroy
    redirect_to habits_path, notice: "Habit deleted!"
  end
  def calendar
    @date = params[:date] ? Date.parse(params[:date]) : Date.today

    start_date = @date.beginning_of_month
    end_date   = @date.end_of_month

    @habits_by_date = current_user.habits
                                  .where(date: start_date..end_date)
                                  .group_by(&:date)
  end

  def dashboard
    @month =
      if params[:month]
        Date.parse(params[:month] + "-01")
      else
        Date.today.beginning_of_month
      end

    @end_month = @month.end_of_month

    habits = current_user.daily_habits
                        .where(date: @month.beginning_of_week(:sunday)..@end_month.end_of_week(:sunday))

    @calendar_data = habits.group_by(&:date)
  end


  private

  def set_habit
    @habit = current_user.habits.find(params[:id])
  end

  def habit_params
    params.require(:habit).permit(:title, :date, :completed)
  end


end
