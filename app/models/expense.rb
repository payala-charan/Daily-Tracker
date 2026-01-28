class Expense < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  validates :category_id, presence: true
  validates :amount, presence: true
end
