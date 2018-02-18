Rails.application.routes.draw do
  resources :accounts, only: :index do
    resources :prospects, only: :index
    resources :responsives, only: :index
  end

  get '/recommendations/kickoff' => 'recommendations#kickoff'
  get '/updates/kickoff' => 'updates#kickoff'

  get '/swipe/:account_id/like/:id' => 'swipe#like'
  get '/swipe/:account_id/pass/:id' => 'swipe#pass'
end
