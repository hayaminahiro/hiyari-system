Rails.application.routes.draw do

  root 'static_pages#top'

  # Authenticator2段階認証
  resource :facility_mfa_session, only: %i(new create update destroy)

  get '/signup', to: 'facilities#new'

  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # Google_API
  get 'auth/:provider/callback', to: 'sessions#sns_login', as: :auth_callback
  get '/auth/failure', to: 'sessions#auth_failure', as: :auth_failure

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
      #二段階認証QRコードモーダル
      get 'authenticator'
      patch 'update_authenticator'
      #二段階認証有効化モーダル
      get 'authenticator_valid'
      patch 'update_authenticator_valid'
      #3階4階月別ヒヤリ(2階：show)
      get 'show_3f'
      get 'show_4f'
      # 施設アカウント削除
      get 'destroy_account'
      patch 'update_destroy_account'
      # 二段階認証使用変更申請
      get 'authenticator_request'
      patch 'update_authenticator_request'
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
          #PDF表示
          get 'show_pdf'
          #担当印押下
          patch 'charge_sign'
          #担当印キャンセル
          patch 'reset_charge_sign'
          #担当係長印押下
          patch 'chief_sign'
          #担当係長印キャンセル
          patch 'reset_chief_sign'
          #リスマネ印押下
          patch 'risk_manager_sign'
          #リスマネ印キャンセル
          patch 'reset_risk_manager_sign'
          #次長印押下
          patch 'director_sign'
          #次長印キャンセル
          patch 'reset_director_sign'
          #施設長印押下
          patch 'facility_manager_sign'
          #施設長印キャンセル
          patch 'reset_facility_manager_sign'
          #最終担当係長印押下
          patch 'last_chief_sign'
          #最終担当係長印キャンセル
          patch 'last_reset_chief_sign'
          #最終リスマネ印押下
          patch 'last_risk_manager_sign'
          #最終リスマネ印キャンセル
          patch 'last_reset_risk_manager_sign'
          #最終次長印押下
          patch 'last_director_sign'
          #最終次長印キャンセル
          patch 'last_reset_director_sign'
          #最終施設長印押下
          patch 'last_facility_manager_sign'
          #最終施設長印キャンセル
          patch 'last_reset_facility_manager'
        end
      end
    end
    resources :accidents do
      collection do
        #新規作成
        get 'new_accidents_index'
        #ヒヤリ集計表
        get 'spreadsheet'
        #3階4階月別ヒヤリ(2階：index)
        get 'index_3f'
        get 'index_4f'
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
