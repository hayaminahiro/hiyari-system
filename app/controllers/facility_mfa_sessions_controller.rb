class FacilityMfaSessionsController < ApplicationController
  skip_before_action :check_mfa

  def new
    @facility = current_facility
  end

  def create
    @facility = current_facility
    if @facility.google_authentic?(params[:auth][:mfa_code])

      FacilityMfaSession.create(@facility)
      redirect_to root_url
    else
      flash.now[:error] = "Wrong code"
      render :new
    end
  end

end
