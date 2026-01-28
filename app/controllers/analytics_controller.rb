class AnalyticsController < ApplicationController
  before_action :require_login

  def index
  end

  def show
    service = AnalyticsService.new(
      user: current_user,
      data_type: params[:data_type],
      analysis_type: params[:analysis_type]
    )

    result = service.call

    @total_amount = result[:total_amount]
    @category_data = result[:category_data]
    @data_type = params[:data_type]
    @analysis_type = params[:analysis_type]
  end
end
