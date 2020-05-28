class Expense < ApplicationRecord
  belongs_to :category
  validates :name, presence: true, length: {minimum: 3}
  validates :amount, presence: true
  validates :date, presence: true
  validates :category_id, presence: true


  def self.filter_by_category(category_id)
    where(category_id: category_id)
  end


end
