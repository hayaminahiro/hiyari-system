class FacilityMfaSessionsController < ApplicationController
  skip_before_action :check_mfa

  def new
    @facility = current_facility
  end

  def create
    @facility = current_facility
    if @facility.google_authentic?(params[:auth][:mfa_code])
      raise
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

end
