class UpdatesKickoffWorker
  include Sidekiq::Worker

  def self.cron_on
    '0 * * * *' # every hour
  end

  def perform
    Account.ids each do |account_id|
      UpdatesWorker.perform_async(account_id)
    end
  end
end
