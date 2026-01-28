class GlobalHabitsController < ApplicationController
  before_action :set_global_habit, only: [:edit, :update, :destroy]

  def index
    @global_habits = current_user.global_habits
  end

  def new
    @global_habit = current_user.global_habits.new
  end

  def create
    @global_habit = current_user.global_habits.new(global_habit_params)
    if @global_habit.save
      redirect_to global_habits_path, notice: "Habit created"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @global_habit.update(global_habit_params)
      redirect_to global_habits_path, notice: "Habit updated"
    else
      render :edit
    end
  end

  def destroy
    @global_habit.destroy
    redirect_to global_habits_path, notice: "Habit deleted"
  end

  private

  def set_global_habit
    @global_habit = current_user.global_habits.find(params[:id])
  end

  def global_habit_params
    params.require(:global_habit).permit(:title, :active)
  end
end
