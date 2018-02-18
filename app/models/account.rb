class Account < ApplicationRecord
  has_many :people
  has_many :prospects
  has_many :responsives
  has_many :updates
  has_one :raw_data, as: :owner

  def self.build_from(raw_data)
    new.tap do |account|
      account.build_raw_data(data: raw_data)
      account.tinder_id = raw_data['user']['_id']
      account.tinder_api_token = raw_data['token']
    end
  end
end
