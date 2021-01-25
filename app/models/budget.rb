class Budget < ApplicationRecord
    has_many :expenses
    has_many :budget_categories, :dependent => :destroy
    has_many :categories, through: :budget_categories

    accepts_nested_attributes_for :budget_categories, :reject_if => lambda { |a| a[:category_id].blank? }, :allow_destroy => true
  
end
  