class SwipeController < ApplicationController

  def prospects
    @prospects = account.prospects
  end

  def like
    prospect = account.prospects.find(params[:id])
    prospect.like!
  end

  def pass
    prospect = account.prospects.find(params[:id])
    prospect.pass!
  end

  private

  def account
    @account ||= Account.find(params[:account_id])
  end
end
