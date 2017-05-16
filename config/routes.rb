Rails.application.routes.draw do
  devise_for :users

  resources :wikis

  resources :charges, only: [:new, :create]

  get 'downgrade' => 'charges#downgrade'

  get 'welcome' => 'welcome#index'

  root to: 'welcome#index'

end
