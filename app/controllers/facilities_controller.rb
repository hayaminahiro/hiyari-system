class FacilitiesController < ApplicationController
  before_action :set_facility, only: [:show, :show_3f, :show_4f, :edit, :update, :destroy, :edit_facility_info, :update_facility_info,
                                      :authenticator, :update_authenticator, :authenticator_valid, :update_authenticator_valid,
                                      :destroy_account, :update_destroy_account, :authenticator_request, :update_authenticator_request]
  before_action :logged_in_facility, only: [:index, :show, :show_3f, :show_4f, :edit, :update, :destroy, :edit_facility_info, :update_facility_info,
                                            :authenticator, :update_authenticator, :authenticator_valid, :update_authenticator_valid,
                                            :destroy_account, :update_destroy_account, :authenticator_request, :update_authenticator_request]
  before_action :correct_facility, only: [:edit, :update, :show, :show_3f, :show_4f, :destroy_account, :update_destroy_account,
                                          :authenticator_request, :update_authenticator_request]
  before_action :admin_facility, only: [:index, :edit_facility_info, :update_facility_info, :authenticator, :update_authenticator,
                                        :authenticator_valid, :update_authenticator_valid]
  before_action :set_hat_accident_count, only: [:show, :show_3f, :show_4f]
  before_action :set_accidents, only: [:show, :show_3f, :show_4f]
  before_action :url_self_admin_reject, only: [:show, :show_3f, :show_4f]

  def index
    @facilities = Facility.all.order(id: "ASC")
  end

  #月別ヒヤリ・事故一覧ページ・・・ログイン/サインアップ後遷移
  def show
  end

  def show_3f
  end

  def show_4f
  end

  def new
    @facility = Facility.new
  end

  def create
    @facility = Facility.new(facility_params)
    if password_valid?
      if @facility.save
        log_in @facility
        if @facility.authenticator_check?
          flash[:success] = '新規作成に成功しました。'
        else
          flash[:info] = "「#{@facility.name}」さん、認証コードを入力して下さい。"
        end
        redirect_to @facility
      else
        flash.now[:danger] = 'このメールアドレスは使用できません。'
        render :new
      end
    else
      flash.now[:danger] = '不正な値があります。確認して下さい。'
      render :new
    end
  end

  def edit
  end

  def update
    if password_valid?
      if @facility.update_attributes(facility_params)
        flash[:success] = "「#{@facility.name}」の施設情報を更新しました。"
        redirect_to @facility
      else
        flash.now[:danger] = 'このメールアドレスは使用できません。'
        render :edit
      end
    else
      flash.now[:danger] = '不正な値があります。確認して下さい。'
      render :edit
    end
  end

  def destroy
    @facility.destroy
    flash[:success] = "「#{@facility.name}」のデータを削除しました。"
    redirect_to facilities_url
  end

  def destroy_account
  end

  def update_destroy_account
    if @facility.authenticate(password_params[:password])
      if @facility.account_delete?
        @facility.update_attributes(account_delete: false)
        flash[:info] = "施設アカウント削除申請を取り消しました。"
        redirect_to destroy_account_facility_url
      else
        @facility.update_attributes(account_delete: true)
        flash[:warning] = "施設アカウントの削除申請をしました。"
        redirect_to destroy_account_facility_url
      end
    else
      flash.now[:danger] = "パスワードが間違っています。"
      render "destroy_account"
    end
  end

  def edit_facility_info
  end

  def update_facility_info
    if @facility.update_attributes(facility_params)
      flash[:success] = "「#{@facility.name}」の施設情報を更新しました。"
    else
      flash[:danger] = "施設情報の更新は失敗しました<br>" + @facility.errors.full_messages.join("<br>")
    end
    redirect_to facilities_url
  end

  def authenticator
  end

  def update_authenticator
    if @facility.display?
      if @facility.update_attributes(display: false)
        flash[:success] = "「#{@facility.name}」さんの二段階認証QRコードを非表示にしました。"
      end
      redirect_to facilities_path
    else
      if @facility.update_attributes(display: true)
        flash[:info] = "「#{@facility.name}」さんの二段階認証QRコードを表示しました。"
      end
      redirect_to facilities_path
    end
  end

  def authenticator_valid
  end

  def update_authenticator_valid
    if @facility.authenticator_check?
      if @facility.update_attributes(authenticator_check: false, authenticator_request: false)
        flash[:success] = "「#{@facility.name}」さんの二段階認証を有効にしました。"
      end
      redirect_to facilities_path
    else
      if @facility.update_attributes(authenticator_check: true, authenticator_request: false)
        flash[:success] = "「#{@facility.name}」さんの二段階認証を無効にしました。"
      end
      redirect_to facilities_path
    end
  end

  def authenticator_request
  end

  def update_authenticator_request
    if @facility.password_digest == nil
      flash[:danger] = "管理者に直接問い合わせて下さい。"
      redirect_to authenticator_request_facility_url
    elsif @facility.authenticate(password_params[:password])
      if @facility.authenticator_check? # 二段階認証がtrue(無効)の場合の処理
        # 申請中(開始or中止)authenticator_request == true
        if @facility.authenticator_request?
          @facility.update_attributes(authenticator_request: false)
          flash[:info] = "二段階認証開始の申請を取り消しました。"
          redirect_to authenticator_request_facility_url
        else
          @facility.update_attributes(authenticator_request: true)
          flash[:info] = "二段階認証開始の申請をしました。"
          redirect_to authenticator_request_facility_url
        end
      else # 二段階認証がfalse(有効)の場合の処理
        if @facility.authenticator_request?
          # 申請中(開始or中止)authenticator_request == true
          @facility.update_attributes(authenticator_request: false)
          flash[:success] = "二段階認証利用中止の申請を取り消しました。"
          redirect_to authenticator_request_facility_url
        else
          @facility.update_attributes(authenticator_request: true)
          flash[:success] = "二段階認証利用中止の申請をしました。"
          redirect_to authenticator_request_facility_url
        end
      end
    else
      flash.now[:danger] = "パスワードが間違っています。"
      render "authenticator_request"
    end
  end

    private

      def facility_params
        params.require(:facility).permit(:name, :email, :password, :password_confirmation, :authenticator_check)
      end

      def password_valid?
        @facility.name.present? && @facility.email.present? && (facility_params[:password] == facility_params[:password_confirmation])
      end

      def password_params
        params.require(:facility).permit(:password)
      end

end
