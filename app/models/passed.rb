class Passed < Person

  def action
    client = Tinder::Client.new(acount.tinder_api_token)
    client.pass(tinder_id)
  end
end
