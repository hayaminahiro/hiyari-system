module SessionsHelper

  # 引数に渡された施設ユーザーオブジェクトでログインします。
  def log_in(facility)
    session[:facility_id] = facility.id
  end

  # セッションと@current_facilityを破棄
  def log_out
    session.delete(:facility_id)
    @current_facility = nil
  end

  # 現在ログイン中の施設ユーザーがいる場合オブジェクトを返します。
  def current_facility
    if session[:facility_id]
      @current_facility ||= Facility.find_by(id: session[:facility_id])
    end
  end

  # 現在ログイン中のユーザーがいればtrue、そうでなければfalseを返します。
  def logged_in?
    !current_facility.nil?
  end

end
