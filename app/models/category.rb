class Category < ApplicationRecord
  has_many :expenses, dependent: :destroy
  has_many :budget_categories
  has_many :budgets, through: :budget_categories
  belongs_to :parent_category, class_name: 'Category', optional: true
  has_many :sub_categories, foreign_key: :parent_id, class_name: 'Category'
  paginates_per 5
end
