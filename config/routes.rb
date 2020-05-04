Rails.application.routes.draw do
  root 'static_pages#top'

  get '/signup', to: 'facilities#new'

  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  #各月ヒヤリ集計表
  get '/facilities/:facility_id/accidents/spreadsheet/:month',
      to: 'accidents#month_spreadsheet', as: :month_spreadsheet
  #各月事故集計表
  get '/facilities/:facility_id/accidents/spreadsheet_accidents/:month',
      to: 'accidents#spreadsheet_accidents', as: :spreadsheet_accidents

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
      resources :accidents do
        member do
          #ヒヤリ閲覧モーダル
          get 'browsing'
          #担当印押下
          patch 'charge_sign'
        end
      end
    end
    resources :accidents do
      collection do
        #新規作成
        get 'new_accidents_index'
        #ヒヤリ集計表
        get 'spreadsheet'
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
