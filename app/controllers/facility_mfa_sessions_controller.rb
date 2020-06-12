class FacilityMfaSessionsController < ApplicationController
  skip_before_action :check_mfa
  before_action :set_current_facility, only: [:new, :create, :update, :destroy]

  def new
  end

  def create
    if @facility.google_authentic?(params[:auth][:mfa_code])
      if FacilityMfaSession.create(@facility)
        flash[:success] = "「#{@facility.name}」さんでログインしました。"
      end
      redirect_to facility_url(current_facility)
    else
      flash.now[:danger] = "認証コードが間違っています。"
      render :new
    end
  end

  def update
    if @facility.google_authentic?(params[:auth][:mfa_code])
      if @facility.display == true
        if @facility.update_attributes(display: false)
          flash[:success] = "QRコードを非表示に変更しました。"
          redirect_to new_facility_mfa_session_url
        end
      else
        if @facility.update_attributes(display: true)
          flash[:warning] = "QRコードを表示します。スキャン後、非表示にする事をお勧めします。"
          redirect_to new_facility_mfa_session_url
        end
      end
    else
      flash[:danger] = "認証コードが間違っています。"
      redirect_to new_facility_mfa_session_url
    end
  end

  def destroy
    if FacilityMfaSession.present?
      log_out if logged_in?
      # Authenticator二段階認証削除
      FacilityMfaSession.destroy
      flash[:success] = "ログインをキャンセルしました。"
      redirect_to root_path
    end
  end

end
