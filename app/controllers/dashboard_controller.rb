class DashboardController < ApplicationController
  before_action :require_login
  def index
    @today = Date.today
    @current_month = @today.beginning_of_month
    @end_of_month = @today.end_of_month
  end
end
