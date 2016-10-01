Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "teachers/new_rating" => 'teachers#new_rating', :as => :new_rating
  resources :teachers do
    post 'upload_avatar', on: :collection
  end

  resources :ratings, only: [:create, :update]

  resources :conversations

  root 'teachers#index'

  # Action Cable
  mount ActionCable.server => '/cable'
end
