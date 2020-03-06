class SessionsController < ApplicationController

  def new
  end

  def create
    facility = Facility.find_by(email: params[:session][:email].downcase)
    if facility && facility.authenticate(params[:session][:password])
      log_in facility
      redirect_to facility
    else
      flash.now[:danger] = '認証に失敗しました。'
      render :new
    end
  end

  def destroy
    log_out
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end

end
