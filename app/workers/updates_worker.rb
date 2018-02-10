class UpdatesWorker
  include Sidekiq::Worker

  attr_reader :account

  def perform(account_id)
    @account = Account.find(account_id)

    update = Update.build_from(update_data)
    update.account = account
    update.save
    ProcessUpdatesWorker.perform_async(update.id)
  end

  private

  def update_data
    client = Tinder::Client.new(tinder_api_token)
    client.updates(last_activity_date)
  end

  def tinder_api_token
    account.tinder_api_token
  end

  def last_activity_date
    account.updates.last&.last_activity_date&.iso8601
  end
end
