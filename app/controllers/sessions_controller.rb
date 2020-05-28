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

  # GoogleAPI
  def sns_login
    facility = Facility.find_or_create_from_auth(request.env['omniauth.auth'])
    if facility.save
      session[:facility_id] = facility.id
      flash[:success] = "#{facility.name}さんでログインしました。"
      redirect_to facility_url(current_facility)
    else
      flash[:danger] = '認証に失敗しました。'
      redirect_to root_url
    end
  end

  def auth_failure
    flash[:danger] = '認証に失敗しました。'
    redirect_to root_url
  end

end
