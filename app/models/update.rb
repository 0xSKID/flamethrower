class Update < ApplicationRecord
  has_one :raw_data, as: :owner
  belongs_to :account
end
