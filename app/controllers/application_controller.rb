class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include SeniorsHelper
  include WorkersHelper
  include AccidentsHelper

  # beforeフィルター

  # paramsハッシュから施設ユーザーを取得します。
  def set_facility
    @facility = Facility.find(params[:id])
  end

  #facility_idを取得
  def set_facility_id
    @facility = Facility.find(params[:facility_id])
  end

  # ログイン済みのユーザーか確認します。
  def logged_in_facility
    unless logged_in?
      store_location
      flash[:danger] = "ログインして下さい。"
      redirect_to login_url
    end
  end

  # アクセスしたユーザーが現在ログインしているユーザーか確認します。
  def correct_facility
    redirect_to(root_url) unless current_facility?(@facility)
  end

  # システム管理権限所有かどうか判定します。
  def admin_facility
    redirect_to root_url unless current_facility.admin?
  end
end
