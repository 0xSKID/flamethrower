class RecommendationsKickoffWorker
  include Sidekiq::Worker

  def self.cron_on
    # At minute 0 past every hour from 8 through 23
    '0 8-23/1 * * *'
  end

  def perform
    Account.ids.each do |account_id|
      RecommendationsWorker.perform_async(account_id)
    end
  end
end
