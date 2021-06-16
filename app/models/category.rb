class Category < ApplicationRecord
  has_many :expenses, dependent: :destroy
  has_many :budget_categories
  has_many :budgets, through: :budget_categories
  belongs_to :parent_category, class_name: 'Category', optional: true
  has_many :sub_categories, foreign_key: :parent_id, class_name: 'Category'
  paginates_per 5

  def get_id_and_child_ids
    ids = Category.where(parent_id: self.id).or(Category.where(id: self.id)).pluck(:id)
  end

end
