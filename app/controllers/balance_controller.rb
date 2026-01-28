class BalanceController < ApplicationController
  before_action :require_login

  def index
    @income = Income.new
    @expenditure = Expenditure.new

    @incomes = current_user.incomes
    @expenditures = current_user.expenditures

    @total_income = current_user.incomes.sum(:amount)
    @total_expenditure = current_user.expenditures.sum(:amount)
    @balance = @total_income - @total_expenditure
  end
end
