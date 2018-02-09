class Matched < Person

  def advance_stage
    return unless advanceable
    send_follow_up
    becomes!(Replied)
  end

  private

  def advanceable
    opened? && awaiting_reply
  end

  def opened?
    sent_messages.length == 1
  end

  def awaiting_reply
    received_messages.last.create_at > person.sent_messages.last.created_at
  end

  def send_follow_up
    send_message(followup_text)
  end

  def followup_text
    'Tell me something about yourself.'
  end
end
