Rails.application.routes.draw do
  root 'static_pages#top'

  get '/signup', to: 'facilities#new'

  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  #施設関連: facilities
  resources :facilities do
    member do #memberはid付与
      #施設情報編集モーダル
      get 'edit_facility_info'
      patch 'update_facility_info'
    end
    #施設利用者関連: seniors
    resources :seniors do
      collection do #collectionはid付与せず
        #施設利用者新規作成
        get 'new_senior'
        post 'create_senior'
      end
      member do #memberはid付与
        #施設利用者編集
        get 'edit_senior'
        patch 'update_senior'
        #施設利用者退所
        patch 'leaving'
        #施設利用者再入所
        patch 're_entry'
      end
      resources :accidents
    end
    resources :accidents do
      collection do
        #ヒヤリ・事故新規作成前の利用者一覧
        get 'seniors_list'
        #利用者別ヒヤリ・事故一覧
        get 'senior_accidents_index'
      end
    end

    #職員関連: workers
    resources :workers do
      collection do #collectionはid付与せず
        #職員新規作成
        get 'new_worker'
        post 'create_worker'
      end
      member do #memberはid付与
        #職員編集
        get 'edit_worker'
        patch 'update_worker'
        #職員退職
        patch 'retirement'
        #職員再就業
        patch 're_employment'
      end
    end
  end

end
