class Expense < ApplicationRecord
  # belongs_to :category
  validates :name, presence: true, length: {minimum: 3}
  validates :amount, presence: true
  validates :date, presence: true
  validates :category_id, presence: true
end
