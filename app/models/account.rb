class Account < ApplicationRecord
  has_many :users
  has_many :expeses
  paginates_per 5
end
