class Replied < Person
  #belongs_to :opener, class_name: SentMessage
  has_one :opener_joins, class_name: Opener
  has_one :reply_joins, class_name: Reply

  has_many :opener, through: :opener_joins, source: :sent_message
  has_many :replies, through: :reply_joins, source: :message #class_name: ReceivedMessage
  has_many :followup, through: :opener_joins, source: :message
  #belongs_to :followup, class_name: SentMessage

  def followup_text
    'Tell me something about yourself.'
  end

  def opener
    sent_message.first
  end

  def replies
    RecievedMessages.where(created_at: 
  end

  def followup
    sent_messages.second
  end
end

p = Person.new()
opener = SentMessage.new()
#p.opener = opener
Opener.new(person: p, message: opener)
p.opener
