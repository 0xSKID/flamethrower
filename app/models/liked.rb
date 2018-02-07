class Liked < Person

  def action
    client = Tinder::Client.new(account.tinder_api_token)
    client.like(tinder_id)
  end
end
