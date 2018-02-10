class Replied < Person

  def advance_stage
    return unless advancable
    becomes!(Responsive)
  end

  private

  def advancable
    followed_up? && awaiting_reply?
  end

  def followed_up?
    sent_messages.length == 2
  end

  def awaiting_reply?
    messages.awaiting_reply?
  end
end
