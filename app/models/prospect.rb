class Prospect < ApplicationRecord
  has_one :raw_data, as: :owner
  belongs_to :account

  def self.build_from(raw_data)
    new.tap do |prospect|
      prospect.build_raw_data(data: raw_data.to_h)
      prospect.name = raw_data.name
      prospect.photos = raw_data.photos.map(&:url).join(' ')
      prospect.tinder_id = raw_data._id
    end
  end
end
