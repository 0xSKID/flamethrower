Rails.application.routes.draw do
  resources :accounts, only: [] do
    resources :prospects, only: :index
  end

  post '/swipe/like' => 'swipe#like'
  post '/swipe/pass' => 'swipe#pass'
end
