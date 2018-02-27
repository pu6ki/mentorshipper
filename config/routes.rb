Rails.application.routes.draw do
  root to: 'technologies#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :questions do
    resources :answers
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
