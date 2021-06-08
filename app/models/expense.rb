class Expense < ApplicationRecord
  paginates_per 10
  belongs_to :category
  belongs_to :account
  validates :name, presence: true, length: {minimum: 3}
  validates :amount, presence: true
  validates :date, presence: true
  validates :category_id, presence: true

  def self.based_account_id(account_id)
    where(account_id: account_id)
  end

  def self.filter_by_category(category_id)
    where(category_id: category_id)
  end

  def self.to_csv
    attributes = %w{id name amount date category_id account_id}
    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |expense|
        csv << expense.attributes.values_at(*attributes)
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Expense.create! row.to_hash
    end
  end

end
