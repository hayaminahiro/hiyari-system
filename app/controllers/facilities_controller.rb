class FacilitiesController < ApplicationController
  before_action :set_facility, only: [:show, :show_3f, :show_4f, :edit, :update, :destroy, :edit_facility_info, :update_facility_info]
  before_action :logged_in_facility, only: [:index, :show, :show_3f, :show_4f, :edit, :update, :destroy, :edit_facility_info, :update_facility_info]
  before_action :correct_facility, only: [:edit, :update, :show, :show_3f, :show_4f]
  before_action :admin_facility, only: [:index, :destroy, :edit_facility_info, :update_facility_info]
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
        flash[:success] = '新規作成に成功しました。'
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


    private

      def facility_params
        params.require(:facility).permit(:name, :email, :password, :password_confirmation)
      end

      def password_valid?
        @facility.name.present? && @facility.email.present? && (facility_params[:password] == facility_params[:password_confirmation])
      end

end
