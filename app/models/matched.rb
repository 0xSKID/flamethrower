class Matched < Person

  def perform_type_action
    send_opener
  end

  private

  def send_opener
    send_message(opener_text)
  end

  def opener_text
    'You seem interesting if you want to chat, just say hi.'
  end
end
