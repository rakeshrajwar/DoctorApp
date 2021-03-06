Rails.application.routes.draw do

  root 'welcome#index'
  # Doorkeeper
  use_doorkeeper do
    controllers :tokens => 'custom_tokens'
  end

  devise_for :users,
  controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations'
  }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resource :profile do
        get :get_cities, on: :collection
      end
      resources :emergency_contacts
      resource :power_of_attorney
      resource :pharmacy
      resource :insurance
      resources :images do
        collection do
          post :avatar, action: 'avatar_create'
          post :photo_id, action: 'photo_id_create'
          get :avatar
          get :photo_id
        end
      end
      resources :diseases do
        get :search, on: :collection                               
        post :add_to_patient, on: :collection
      end
      resources :allergies do
        get :search, on: :collection                               
        post :add_to_patient, on: :collection
      end
    end
  end
end
