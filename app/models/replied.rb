class Replied < Person

  def perform_type_action
    send_followup
  end

  private

  def send_followup
    send_message(followup_text)
  end

  def followup_text
    'Tell me something about yourself.'
  end
end
