# app/controllers/downloads_controller.rb
class DownloadsController < ApplicationController
  before_action :require_login

  def index
  end

  def export
    return redirect_invalid unless valid_params?

    records = fetch_records

    if params[:file_type] == "excel"
      export_excel(records)
      return
    end

    if params[:file_type] == "pdf"
      export_pdf(records)
      return
    end
  end

  private
  # VALIDATION
  def valid_params?
    %w[income expense expenditure].include?(params[:data_type]) &&
      %w[excel pdf].include?(params[:file_type])
  end

  def redirect_invalid
    redirect_to downloads_path, alert: "Invalid download request"
  end
  # DATA FETCHING
  def fetch_records
    case params[:data_type]
    when "income"
      current_user.incomes
    when "expense"
      current_user.expenses
    when "expenditure"
      current_user.expenditures
    else
      []
    end
  end
  # EXCEL EXPORT
  def export_excel(records)
    package  = Axlsx::Package.new
    workbook = package.workbook

    workbook.add_worksheet(name: "Data") do |sheet|
      sheet.add_row ["Title", "Amount", "Date"]
      records.each do |record|
        sheet.add_row [
          record.try(:title),
          record.amount,
          record.created_at.strftime("%d-%m-%Y")
        ]
      end
      sheet.add_row []
      sheet.add_row ["Total", total_amount(records)]
    end

    send_data package.to_stream.read,
          filename: export_filename("xlsx"),
          type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
          disposition: "attachment"
    return

  end
  # PDF EXPORT
  def export_pdf(records)
    pdf = Prawn::Document.new
    pdf.text report_title, size: 18, style: :bold
    pdf.move_down 10
    records.each do |record|
      pdf.text "Title: #{record.try(:title)}"
      pdf.text "Amount: #{record.amount}"
      pdf.text "Date: #{record.created_at.strftime('%d-%m-%Y')}"
      pdf.move_down 8
    end
    pdf.move_down 10
    pdf.text "Total Amount: #{total_amount(records)}", style: :bold
    send_data pdf.render,
              filename: export_filename("pdf"),
              type: "application/pdf",
              disposition: "attachment"
  end

  # HELPERS
  def report_title
    "#{params[:data_type].capitalize} Report"
  end

  def export_filename(ext)
    "#{params[:data_type]}s_#{Time.current.strftime('%Y%m%d')}.#{ext}"
  end
  def total_amount(records)
    records.sum(&:amount)
  end
end
