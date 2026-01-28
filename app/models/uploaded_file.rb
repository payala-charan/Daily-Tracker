# app/models/uploaded_file.rb
class UploadedFile < ApplicationRecord
  belongs_to :user
  has_one_attached :file

  # -----------------------------
  # FILE SIZE VALIDATION
  # -----------------------------
  #validates :file, size: { less_than: 100.megabytes }

  # -----------------------------
  # ALLOWED CONTENT TYPES
  # -----------------------------
  ALLOWED_TYPES = %w[
    application/pdf
    application/msword
    application/vnd.openxmlformats-officedocument.wordprocessingml.document
    application/vnd.ms-excel
    application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
    text/html
    application/pgp-encrypted
  ]

  #validates :file, content_type: ALLOWED_TYPES

  # -----------------------------
  # AUTO CATEGORY ASSIGNMENT
  # -----------------------------
  before_save :assign_category

  private

  def assign_category
    return unless file.attached?

    if file.content_type.include?("excel") ||
       file.content_type.include?("spreadsheet")
      self.file_type = "Spreadsheet"
    elsif file.content_type.include?("pdf")
      self.file_type = "Document"
    elsif file.content_type.include?("html")
      self.file_type = "Web File"
    elsif file.content_type.include?("pgp")
      self.file_type = "Encrypted"
    elsif file.content_type.include?("jpeg")
      self.file_type = "Jpeg"
    else
      self.file_type = "Other"
    end
  end
end
