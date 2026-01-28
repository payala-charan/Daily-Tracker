# app/services/analytics_service.rb
class AnalyticsService
  def initialize(user:, data_type:, analysis_type:)
    @user = user
    @data_type = data_type
    @analysis_type = analysis_type
  end

  def call
    range = date_range
    records = fetch_records(range)

    total = records.sum(:amount)

    # 👉 ONLY expenses have categories
    category_data =
      if @data_type == "expense"
        records
          .group(:category)
          .sum(:amount)
          .map do |category, amount|
            {
              category: category,
              amount: amount,
              percentage: percentage(amount, total)
            }
          end
      else
        [] # very important
      end

    # ✅ MUST RETURN THIS HASH
    {
      total_amount: total,
      category_data: category_data
    }
  end

  private

  def date_range
    case @analysis_type
    when "weekly"
      Time.current.beginning_of_week..Time.current.end_of_week
    when "monthly"
      Time.current.beginning_of_month..Time.current.end_of_month
    when "quarterly"
      3.months.ago.beginning_of_day..Time.current.end_of_day
    when "yearly"
      Time.current.beginning_of_year..Time.current.end_of_year
    else
      Time.current.beginning_of_day..Time.current.end_of_day
    end
  end

  def fetch_records(range)
    case @data_type
    when "expense"
      @user.expenses.where(created_at: range)
    when "income"
      @user.incomes.where(created_at: range)
    when "expenditure"
      @user.expenditures.where(created_at: range)
    else
      @user.expenses.none
    end
  end

  def percentage(amount, total)
    return 0 if total.zero?
    ((amount.to_f / total) * 100).round(2)
  end
end
