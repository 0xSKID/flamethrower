class Replied < Person

  def advance_stage
    return unless advancable
    becomes!(Responsive)
  end

  private

  def advancable
    followed_up? && awaiting_reply
  end

  def followed_up?
    send_messages.length == 2
  end

  def awaiting_reply
    received_messages.last.create_at > person.sent_messages.last.created_at
  end
end
