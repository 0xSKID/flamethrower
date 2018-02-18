class ResponsivesController < ApplicationController

  def index
    responsives = account.responsives
    render json: responsives
  end

  private

  def account
    @account ||= Account.find(params[:account_id])
  end
end
