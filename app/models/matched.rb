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
    if last_received_creation_date && last_sent_creation_date
      last_received_creation_date > last_sent_creation_date
    else
     false
    end
  end

  def last_received_creation_date
    received_messages.last&.created_at
  end

  def last_sent_creation_date
    sent_messages.last&.created_at
  end

  def send_follow_up
    send_message(follow_up_text)
  end

  def follow_up_text
    'Tell me something about yourself.'
  end
end
