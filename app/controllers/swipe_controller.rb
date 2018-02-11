class SwipeController < ApplicationController

  def like
    prospect = account.prospects.find(params[:id])
    prospect.like!
    render json: prospect
  end

  def pass
    prospect = account.prospects.find(params[:id])
    prospect.pass!
    render json: prospect
  end

  private

  def account
    @account ||= Account.find(params[:account_id])
  end
end
