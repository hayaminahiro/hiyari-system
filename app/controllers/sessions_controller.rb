class SessionsController < ApplicationController

  def new
  end

  def create
    facility = Facility.find_by(email: params[:session][:email].downcase)
    if facility && facility.authenticate(params[:session][:password])
      log_in facility
      params[:session][:remember_me] == '1' ? remember(facility) : forget(facility)
      redirect_back_or facility
    else
      flash.now[:danger] = '認証に失敗しました。'
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    flash[:info] = 'ログアウトしました。'
    redirect_to root_url
  end

end