class Person < ApplicationRecord
  belongs_to :account
  has_one :raw_data, as: :owner
  has_many :messages
  has_many :updates

  def received_messages
    messages.where(type: 'ReceivedMessage')
  end

  def sent_messages
    messages.where(type: 'SentMessage')
  end

  private

  def send_message(message)
    client = Tinder::Client.new(account.tinder_api_token)
    client.message(tinder_id, message)
  end
end
