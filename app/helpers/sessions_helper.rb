module SessionsHelper

  # 引数に渡された施設ユーザーオブジェクトでログインします。
  def log_in(facility)
    session[:facility_id] = facility.id
  end

  # 永続的セッションを記憶
  def remember(facility)
    facility.remember
    cookies.permanent.signed[:facility_id] = facility.id
    cookies.permanent[:remember_token] = facility.remember_token
  end

  # 永続的セッションを破棄
  def forget(facility)
    facility.forget
    cookies.delete(:facility_id)
    cookies.delete(:remember_token)
  end

  # セッションと@current_facilityを破棄
  def log_out
    forget(current_facility)
    session.delete(:facility_id)
    @current_facility = nil
  end

  # 現在ログイン中の施設ユーザーがいる場合オブジェクトを返します。
  # それ以外の場合はcookiesに対応するユーザーを返します。
  def current_facility
    if (facility_id = session[:facility_id])
      @current_facility ||= Facility.find_by(id: facility_id)
    elsif (facility_id = cookies.signed[:facility_id])
      facility = Facility.find_by(id: facility_id)
      if facility && facility.authenticated?(cookies[:remember_token])
        log_in facility
        @current_facility = facility
      end
    end
  end

  # 現在ログイン中のユーザーがいればtrue、そうでなければfalseを返します。
  def logged_in?
    !current_facility.nil?
  end

end
