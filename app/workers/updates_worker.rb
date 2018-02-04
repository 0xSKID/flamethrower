class UpdatesWorker
  include Sidekiq::Worker

  attr_reader :account

  def perform(account_id)
    @account = Account.find(account_id)
    
    update = Update.new(account: account)
    update.build_raw_data(data: response)
    update.save!
    ProcessUpdatesWorker.perform_async(update.id)
   # not sure how im going to do this with last acitvity date changing the structure of the feedback data how do we
   # know:
  end

  def update
    last_activity_date = account.updates.last.pluck(:created_at).string_format
    client = Tinder::Client.new(account.tinder_api_token)
    client.updates(last_activity_date)
  end
end
