class Message < ApplicationRecord
  belongs_to :person

  def self.build_from(raw_data)
    Message.new.tap do |message|
      message.tinder_id = raw_data['_id']
      message.to_tinder_id = raw_data['to']
      message.from_tinder_id = raw_data['from']
      message.tinder_timestamp = raw_data['sometimestamp']
    end
  end

  def derive_type
    return 'Message' unless person
    if message.from_tinder_id == person.tinder_id
      'ReceivedMessage'
    else
      'SentMessage'
    end
  end
end


