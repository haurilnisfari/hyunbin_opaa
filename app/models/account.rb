class Account < ApplicationRecord
  has_many :users
  has_many :expeses
end
