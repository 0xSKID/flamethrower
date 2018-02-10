class Person < ApplicationRecord
  belongs_to :account
  has_one :raw_data, as: :owner
  has_many :messages do
    def awaiting_reply
      last.is_a?(ReceivedMessage)
    end
  end
  has_many :updates

  def received_messages
    ReceivedMessage.where(person: self)
  end

  def sent_messages
    SentMessage.where(person: self)
  end

  def send_message(message)
    tinder.message(tinder_id, message)
  end

  protected

  def tinder
    @client ||= Tinder::Client.new(account.tinder_api_token)
  end
end
