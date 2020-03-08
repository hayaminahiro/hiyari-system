Rails.application.routes.draw do
  root 'static_pages#top'

  get '/signup', to: 'facilities#new'

  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :facilities do
    member do
      get 'edit_facility_info'
      patch 'update_facility_info'
    end
    resources :seniors
  end

end
