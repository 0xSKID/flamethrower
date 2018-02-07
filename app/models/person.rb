class Person < ApplicationRecord
  belongs_to :account
  has_one :raw_data, as: :owner
  has_many :messages
  has_many :updates

  def set_type
    return if immutable_types.include?(type)

    if messages.empty?
      self.type = 'Prospect'
    elsif messages.length == 1
      self.type = 'Match'
    elsif received_messages.length > 0 && sent_messages.length == 1
      self.type = 'Replied'
    elsif sent_messages.length > 1
      self.type = 'Responsive'
    end
  end

  def received_messages
    messages.where(type: 'ReceivedMessage')
  end

  def sent_messages
    messages.where(type: 'SentMessage')
  end

  def perform_type_action; end

  def opener
    sent_messages.first
  end

  def replies
    recieved_messages
      .where(created_at: open.created_at..followup.created_at)
  end

  def followup
    sent_messages.second
  end

  def conversation
    messages.ordered_by(:created_at).map(&:text)
  end

  private

  def send_message(message)
    client = Tinder::Client.new(account.tinder_api_token)
    client.message(tinder_id, message)
  end

  def immutable_types
    ['Dated', 'Lost']
  end
end
