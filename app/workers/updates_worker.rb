class UpdatesWorker
  include Sidekiq::Worker

  attr_reader :account

  def perform(account_id)
    @account = Account.find(account_id)

    update = Update.new(account: account)
    update.build_raw_data(data: update_data)
    update.save
    ProcessUpdatesWorker.perform_async(update.id)
  end

  def update_data
    last_activity_date = account.updates.last&.pluck(:created_at)&.iso8601
    client = Tinder::Client.new(account.tinder_api_token)
    client.updates(last_activity_date)
  end
end
