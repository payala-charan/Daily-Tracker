class TargetsController < ApplicationController
  before_action :require_login
  before_action :set_target, only: [:edit, :update, :destroy]

  def index
    @targets = current_user.targets.order(target_date: :asc)
  end

  def new
    @target = Target.new
  end

  def create
    @target = current_user.targets.new(target_params)

    if @target.save
      redirect_to targets_path, notice: "Target created successfully"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @target.update(target_params)
      redirect_to targets_path, notice: "Target updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @target.destroy
    redirect_to targets_path, notice: "Target deleted successfully"
  end

  private

  def set_target
    @target = current_user.targets.find(params[:id])
  end

  def target_params
    params.require(:target).permit(:target_name, :target_date, :description)
  end
end
