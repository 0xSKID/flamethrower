class Matched < Person

  def advance_stage
    return unless advanceable
    send_follow_up
    becomes!(Replied)
  end

  private

  def advanceable
    opened? && awaiting_reply?
  end

  def awaiting_reply?
    messages.awaiting_reply?
  end

  def opened?
    sent_messages.length == 1
  end

  def send_follow_up
    send_message(follow_up_text)
  end

  def follow_up_text
    'Tell me something about yourself.'
  end
end
