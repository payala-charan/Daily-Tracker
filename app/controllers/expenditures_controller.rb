class ExpendituresController < ApplicationController
  before_action :require_login
  before_action :set_expenditure, only: [:edit, :update, :destroy]

  # def index
  #   @expenditures = current_user.expenditures
  # end

  # def new
  #   @expenditure = current_user.expenditures.new
  # end

  def create
    @expenditure = current_user.expenditures.new(expenditure_params)
    if @expenditure.save
      redirect_to balance_path, notice: "Expenditure added"
    else
      render :new
    end
  end

  def edit; end

  def update
    if @expenditure.update(expenditure_params)
      redirect_to balance_path, notice: "Expenditure updated"
    else
      render :edit
    end
  end

  def destroy
    @expenditure.destroy
    redirect_to balance_path, notice: "Expenditure deleted"
  end

  private

  def set_expenditure
    @expenditure = current_user.expenditures.find(params[:id])
  end

  def expenditure_params
    params.require(:expenditure).permit(:title, :amount)
  end
end
