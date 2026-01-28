class ExpensesController < ApplicationController
  before_action :require_login
  before_action :set_expense, only: [:edit, :update, :destroy]
  def index
    #@categories = current_user.categories
    @expense = Expense.new
    @expenses = current_user.expenses.includes(:category).order(created_at: :desc)
    @categories = current_user.categories.order(:name)
  end


  def create
    @expense = current_user.expenses.new(expense_params)

    if @expense.save
      redirect_to expenses_path, notice: "Expense added successfully"
    else
      # @categories = current_user.categories.order(:name)
      # @expenses = current_user.expenses.order(created_at: :desc)
      # render :index
      load_collections
      render :index
    end
  end

  def edit
    load_collections
  end

  def update
    if @expense.update(expense_params)
      redirect_to expenses_path, notice: "Expense updated successfully"
    else
      load_collections
      render :edit
    end
  end

  def destroy
    @expense.destroy
    redirect_to expenses_path, notice: "Expense deleted successfully"
  end


  private

  def set_expense
    @expense = current_user.expenses.find(params[:id])
  end

  def load_collections
    @categories = current_user.categories.order(:name)
  end

  def expense_params
    params.require(:expense).permit( :amount, :category_id)
  end
end
