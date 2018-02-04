class Matched < Person
  has_one :opener, class_name: SentMessage

  def opener_text
    'You seem interesting if you want to chat, just say hi.'
  end
end
