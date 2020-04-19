class FacilitiesController < ApplicationController
  before_action :set_facility, only: [:edit, :update, :destroy, :edit_facility_info, :update_facility_info]
  before_action :logged_in_facility, only: [:index, :edit, :update, :destroy, :edit_facility_info, :update_facility_info]
  before_action :correct_facility, only: [:edit, :update]
  before_action :admin_facility, only: [:destroy, :edit_facility_info, :update_facility_info]

  def index
    @facilities = Facility.all.order(id: "ASC")
  end

  #月別ヒヤリ・事故一覧ページ・・・ログイン/サインアップ後遷移
  def show
    @facility = Facility.find(params[:id])
    @accidents2f = Accident.includes(:senior).where(accident_floor: 2).order(accident_datetime: :desc)
    @accidents3f = Accident.includes(:senior).where(accident_floor: 3).order(accident_datetime: :desc)
    @accidents4f = Accident.includes(:senior).where(accident_floor: 4).order(accident_datetime: :desc)
    @hat_count2f = Accident.includes(:senior).where(accident_floor: 2).where(which_accident: "ヒヤリハット").order(accident_datetime: :desc)
    @accident_count2f = Accident.includes(:senior).where(accident_floor: 2).where(which_accident: "事故").order(accident_datetime: :desc)
    @hat_count3f = Accident.includes(:senior).where(accident_floor: 3).where(which_accident: "ヒヤリハット").order(accident_datetime: :desc)
    @accident_count3f = Accident.includes(:senior).where(accident_floor: 3).where(which_accident: "事故").order(accident_datetime: :desc)
    @hat_count4f = Accident.includes(:senior).where(accident_floor: 4).where(which_accident: "ヒヤリハット").order(accident_datetime: :desc)
    @accident_count4f = Accident.includes(:senior).where(accident_floor: 4).where(which_accident: "事故").order(accident_datetime: :desc)
  end

  def new
    @facility = Facility.new
  end

  def create
    @facility = Facility.new(facility_params)
    if @facility.save
      log_in @facility
      flash[:success] = '新規作成に成功しました。'
      redirect_to @facility
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @facility.update_attributes(facility_params)
      flash[:success] = "「#{@facility.name}」の施設情報を更新しました。"
      redirect_to @facility
    else
      render :edit
    end
  end

  def destroy
    @facility.destroy
    flash[:success] = "「#{@facility.name}」のデータを削除しました。"
    redirect_to facilities_url
  end

  def edit_facility_info
  end

  def update_facility_info
    if @facility.update_attributes(facility_params)
      flash[:success] = "「#{@facility.name}」の施設情報を更新しました。"
    else
      flash[:danger] = "施設情報の更新は失敗しました<br>" + @facility.errors.full_messages.join("<br>")
    end
    redirect_to facilities_url
  end


    private

      def facility_params
        params.require(:facility).permit(:name, :email, :password, :password_confirmation)
      end

end
