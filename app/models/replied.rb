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
    sent_messages.length == 2
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
end
