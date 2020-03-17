class SeniorsController < ApplicationController
  #before_action :set_facility, only: [:show, :edit, :update, :destroy, :edit_facility_info, :update_facility_info]
  #before_action :logged_in_facility, only: [:index, :show, :edit, :update, :destroy, :edit_facility_info, :update_facility_info]

  def index
    @facility = Facility.find(params[:facility_id])
    @senior = @facility.seniors.find_by(params[:id])
    @seniors = Senior.all.includes(:facility)
    @seniors2f = Senior.where(floor: 2).where(using_flg: true).order(:senior_name_call)
    @seniors3f = Senior.where(floor: 3).where(using_flg: true).order(:senior_name_call)
    @seniors4f = Senior.where(floor: 4).where(using_flg: true).order(:senior_name_call)
    @seniors_off = Senior.where(using_flg: false).order(:senior_name_call)
  end

  def show
  end

  def new_senior
    @facility = Facility.find(params[:facility_id])
    @senior = Senior.new
    @seniors2f = Senior.where(floor: 2).where(using_flg: true)
    @seniors3f = Senior.where(floor: 3).where(using_flg: true)
    @seniors4f = Senior.where(floor: 4).where(using_flg: true)
    @seniors_off = Senior.where(using_flg: false)
  end

  def create_senior
    @facility  = Facility.find(params[:facility_id])
    @senior = @facility.seniors.new(senior_params)
    @seniors2f = Senior.where(floor: 2).where(using_flg: true)
    @seniors3f = Senior.where(floor: 3).where(using_flg: true)
    @seniors4f = Senior.where(floor: 4).where(using_flg: true)
    @seniors_off = Senior.where(using_flg: false)
    if @senior.save
      flash[:success] = "利用者を新規登録しました。"
    else
      flash[:danger] = "未入力項目があります。"
    end
    redirect_to facility_seniors_url
  end

  def edit_senior
    @facility = Facility.find(params[:facility_id])
    @senior = @facility.seniors.find(params[:id])
  end

  def update_senior
    @facility = Facility.find(params[:facility_id])
    @senior = @facility.seniors.find(params[:id])
    if @senior.update_attributes(senior_params)
      flash[:success] = "利用者情報を更新しました。"
    else
      flash[:danger] = "入力項目に誤りがあります。"
    end
    redirect_to facility_seniors_url
  end

  private

    def senior_params
      params.require(:senior).permit(:senior_name, :senior_name_call, :floor, :charge_worker, :using_flg)
    end

end
