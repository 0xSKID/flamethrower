class SwipeWorker
  include Sidekiq::Worker

  def perform(prospect_id)
    #prospect = Prospect.find(prospect_id)
    # hit AWS Lambda with photo set
    # likes/pass based on confidence
  end
end
