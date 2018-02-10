class Update < ApplicationRecord
  has_one :raw_data, as: :owner
  belongs_to :account

  def self.build_from(raw_data)
    Update.new.tap do |update|
      update.build_raw_data(data: raw_data)
      update.last_activity_date = Time.parse(raw_data['last_activity_date'])
    end
  end
end
