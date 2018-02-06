class RecommendationsWorker
  include Sidekiq::Worker

  attr_reader :account

  def perform(account_id)
    @account = Account.find(account_id)

    recommendations.each do |recommendation|
      next if tinder_ids.include?(recommendation['_id'])
      prospect = Prospect.build_from(recommendation)
      prospect.account = account
      prospect.save
      SwipeWorker.perform_async(prospect.id)
    end
  end

  private

  def recommendations
    response = Tinder::Client.new(account.tinder_api_token).recommendations
    response['results'] || []
  end

  def tinder_ids
    @tinder_ids ||= account.prospects.pluck(:tinder_id)
  end
end

