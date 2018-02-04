class Responsive < Person
  has_many :sent, class_name: SentMessage
  has_many :received, class_name: ReceivedMessage

  def conversation
    messages.ordered_by(:created_at).map(&:text)
  end
end
