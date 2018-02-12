class RecommendationsController < ApplicationController

  def kickoff
    RecommendationsWorker.perform_async(account_id) if account_id
    render json: { 'status' => 'success' }
  end

  private

  def account_id
    @account_id ||= Account.find_by(id: params[:account_id])&.id
  end
end
