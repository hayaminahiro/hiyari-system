class FacilityMfaSessionsController < ApplicationController
  skip_before_action :check_mfa

  def new
    @facility = current_facility
  end

  def create
    @facility = current_facility
    if @facility.google_authentic?(params[:auth][:mfa_code])
      FacilityMfaSession.create(@facility)
      if @facility.email == "center@email.com"
        flash[:success] = "テストユーザー「社会福祉法人うみの風」さんでログインしました。"
      else
        flash[:success] = "「#{@facility.name}」さんでログインしました。"
      end
      redirect_to facility_url(current_facility)
    else
      flash.now[:danger] = "認証コードが間違っています。"
      render :new
    end
  end

  def update
    @facility = current_facility
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
end
