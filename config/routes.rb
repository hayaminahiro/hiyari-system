Rails.application.routes.draw do
  root 'static_pages#top'

  get '/signup', to: 'facilities#new'

  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :facilities do
    member do #memberはid付与
      #施設情報編集モーダル
      get 'edit_facility_info'
      patch 'update_facility_info'
    end
    resources :seniors do
      collection do #collectionはid付与せず
        #施設利用者新規作成
        get 'new_senior'
        post 'create_senior'
      end
      member do
        #施設利用者新規作成
        get 'edit_senior'
        patch 'update_senior'
      end
    end
  end

end
