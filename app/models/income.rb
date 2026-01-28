class Income < ApplicationRecord
  belongs_to :user
  validates :title, :amount, presence: true
end
