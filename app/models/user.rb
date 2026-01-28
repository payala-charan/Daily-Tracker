class User < ApplicationRecord
    has_secure_password
    has_many :expenses, dependent: :destroy
    has_many :categories, dependent: :destroy
    has_many :notes, dependent: :destroy
    has_many :meetings, dependent: :destroy
    has_many :targets, dependent: :destroy
    has_many :incomes, dependent: :destroy
    has_many :expenditures, dependent: :destroy
    has_many :uploaded_files, dependent: :destroy
    has_many :habits, dependent: :destroy
    has_many :global_habits, dependent: :destroy
    has_many :daily_habits, dependent: :destroy
    has_many :contacts, dependent: :destroy
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true

    after_create :create_default_categories

    private

    def create_default_categories
        ["Food", "Travel", "Entertainment", "Other"].each do |cat|
            categories.create(name: cat)
        end
    end

end
