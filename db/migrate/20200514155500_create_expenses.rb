class CreateExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :expenses do |t|
      t.text :name
      t.integer :amount
      t.datetime :date
      t.integer :category_id
    end
  end
end
