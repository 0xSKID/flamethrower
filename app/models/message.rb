class Message < ApplicationRecord
  has_one :raw_data, as: :owner
  belongs_to :person

  before_create :derive_type

  class << self
    def build_from(raw_data)
      new.tap do |message|
        message.build_raw_data(data: raw_data)
        message.tinder_id = raw_data['_id']
        message.to_tinder_id = raw_data['to']
        message.from_tinder_id = raw_data['from']
        message.text = raw_data['message']
        message.tinder_timestamp = Time.parse(raw_data['created_date'])
      end
    end

    def awating_reply?
      last.is_a?(ReceivedMessage)
    end
  end

  private

  def derive_type
    if from_tinder_id == person.tinder_id
      becomes!(ReceivedMessage)
    elsif from_tinder_id == person.account.tinder_id
      becomes!(SentMessage)
    end
  end
end
