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

  def sns_login
    facility = Facility.from_omniauth(request.env["omniauth.auth"])
    # raise
    if facility.save!
      session[:facility_id] = facility.id
      flash[:success] = "#{facility.name}さんでログインしました。"
      redirect_to root_path
    else
      flash[:danger] = '認証に失敗しました。'
      redirect_to auth_failure_path
    end
  end

  def auth_failure
    flash[:danger] = '認証に失敗しました。'
    redirect_to root_url
  end



end
