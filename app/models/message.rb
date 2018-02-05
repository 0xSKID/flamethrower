class Message < ApplicationRecord
  has_one :raw_data, as: :owner
  belongs_to :person

  def self.build_from(raw_data)
    Message.new.tap do |message|
      message.build_raw_data(data: raw_data)
      message.tinder_id = raw_data['_id']
      message.to_tinder_id = raw_data['to']
      message.from_tinder_id = raw_data['from']
      message.tinder_timestamp = raw_data['sometimestamp']
    end
  end

  def set_type
    if person.nil?
      self.type = 'Message'
    elsif message.from_tinder_id == person.tinder_id
      self.type = 'ReceivedMessage'
    else
      self.type = 'SentMessage'
    end
  end
end
