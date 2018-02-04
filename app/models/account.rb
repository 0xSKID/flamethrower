class Account < ApplicationRecord
  has_many :prospects
  has_many :updates
end
