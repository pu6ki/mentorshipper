Rails.application.routes.draw do
  root to: 'users#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  namespace :users, path: 'users' do
    resources :teams
    resources :mentors
  end

  get 'technologies' => 'technologies#index'

  resources :questions do
    resources :answers
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
