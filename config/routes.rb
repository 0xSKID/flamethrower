Rails.application.routes.draw do
  resources :accounts, only: :index do
    resources :prospects, only: :index
  end

  get '/swipe/:account_id/like/:id' => 'swipe#like'
  get '/swipe/:account_id/pass/:id' => 'swipe#pass'
end
