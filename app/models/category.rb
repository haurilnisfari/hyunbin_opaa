class Category < ApplicationRecord
  has_many :expenses
  has_many :budget_categories
  has_many :budgets, through: :budget_categories
end
