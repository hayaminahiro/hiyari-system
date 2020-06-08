class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include SeniorsHelper
  include WorkersHelper
  include AccidentsHelper

  # AuthenticatorをOFFにしたいなら下記をコメントアウト
  before_action :check_mfa

  # beforeフィルター

  # paramsハッシュから施設ユーザーを取得します。
  def set_facility
    @facility = Facility.find(params[:id])
  end

  #facility_idを取得
  def set_facility_id
    @facility = Facility.find(params[:facility_id])
  end

  #senior_idを取得
  def set_senior_id
    @senior = @facility.seniors.find(params[:senior_id])
  end

  #seniorのidを取得
  def set_senior
    @senior = @facility.seniors.find(params[:id])
  end

  #workerのidを取得
  def set_worker_id
    @worker = @facility.workers.find(params[:id])
  end

  #accidentのidを取得
  def set_accident_id
    @accident = @senior.accidents.find(params[:id])
  end

  #利用者＆ヒヤリ・事故一覧取得
  def set_seniors
    @seniors2f = Senior.including_facility.floor(2).using.name_sorted
    @seniors3f = Senior.including_facility.floor(3).using.name_sorted
    @seniors4f = Senior.including_facility.floor(4).using.name_sorted
  end

  #各階ヒヤリ・事故取得
  def set_accidents
    @accidents2f = Accident.including_senior.floor(2).accidents_sorted
    @accidents3f = Accident.including_senior.floor(3).accidents_sorted
    @accidents4f = Accident.including_senior.floor(4).accidents_sorted
  end

  #ヒヤリ & 事故カウント数取得
  def set_hat_accident_count
    @hat_count2f = Accident.including_senior.floor(2).hat
    @hat_count3f = Accident.including_senior.floor(3).hat
    @hat_count4f = Accident.including_senior.floor(4).hat
    @accident_count2f = Accident.including_senior.floor(2).accident
    @accident_count3f = Accident.including_senior.floor(3).accident
    @accident_count4f = Accident.including_senior.floor(4).accident
  end

  #各月の@monthを取得
  def set_month
    #@monthは、各月1日〜月末までを表す。accident_datetimeで使用
    day = params[:month].to_date
    first_day = day.beginning_of_month
    last_day = first_day.end_of_month
    @month = first_day..last_day
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

  # 自分以外のページへのアクセス拒否
  def url_page_reject
    unless @facility.id == current_facility.id
      redirect_to root_url
    end
  end

  # 管理者自身のページへのアクセス拒否
  def url_self_admin_reject
    if current_facility.admin?
      if @facility.id == 1
        redirect_to root_url
      end
    end
  end

    private
      def check_mfa
        # もし認証済みでなければ・・・（ログイン前＆ログイン後）
        if !(facility_mfa_session = FacilityMfaSession.find) && (facility_mfa_session ? facility_mfa_session.record == current_facility : !facility_mfa_session) && logged_in?
          # raise
          # 認証画面へ遷移
          redirect_to new_facility_mfa_session_url
        end
      end

end
