class ProspectsController < ApplicationController

  def index
    prospects = account.prospects
    render(prospects)
  end

  private

  def account
    @account ||= Account.find(params[:account_id])
  end
end
