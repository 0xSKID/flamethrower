class Liked < Person

  def advance_stage
    send_opener
    becomes!(Matched)
  end

  private

  def send_opener
    send_message(opener_text)
  end

  def opener_text
    'You seem interesting if you want to chat, just say hi.'
  end
end
