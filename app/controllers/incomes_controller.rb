class IncomesController < ApplicationController
  before_action :require_login
  before_action :set_income, only: [:edit, :update, :destroy]

  # def index
  #   @incomes = current_user.incomes
  # end

  # def new
  #   @income = current_user.incomes.new
  # end

  def create
    @income = current_user.incomes.new(income_params)
    if @income.save
      redirect_to balance_path, notice: "Income added"
    else
      render :new
    end
  end

  def edit; end

  def update
    if @income.update(income_params)
      redirect_to balance_path, notice: "Income updated"
    else
      render :edit
    end
  end

  def destroy
    @income.destroy
    redirect_to balance_path, notice: "Income deleted"
  end

  private

  def set_income
    @income = current_user.incomes.find(params[:id])
  end

  def income_params
    params.require(:income).permit(:title, :amount)
  end
end
