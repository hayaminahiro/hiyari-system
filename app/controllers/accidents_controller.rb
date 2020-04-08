class AccidentsController < ApplicationController

  before_action :set_facility_id, only: [:index, :show, :senior_accidents_index, :new, :create]
  #before_action :logged_in_facility, only: [:index, :edit, :update, :destroy, :edit_facility_info, :update_facility_info]
  #before_action :correct_facility, only: [:edit, :update]
  #before_action :admin_facility, only: [:destroy, :edit_facility_info, :update_facility_info]

  #利用者別ヒヤリ一覧・報告書作成(senior_accidents_index)ページダミー
  def index
    @seniors2f = Senior.where(floor: 2).where(using_flg: true).order(:senior_name_call)
    @seniors3f = Senior.where(floor: 3).where(using_flg: true).order(:senior_name_call)
    @seniors4f = Senior.where(floor: 4).where(using_flg: true).order(:senior_name_call)
    @seniors_off = Senior.where(using_flg: false).order(:senior_name_call)
    @accidents2f = Accident.includes(:senior).where(accident_floor: 2).order(accident_datetime: "desc")
    @accidents3f = Accident.includes(:senior).where(accident_floor: 3).order(accident_datetime: "desc")
    @accidents4f = Accident.includes(:senior).where(accident_floor: 4).order(accident_datetime: "desc")
  end

  def show
    @senior = @facility.seniors.find(params[:senior_id])
    @accident = @senior.accidents.find(params[:id])
  end

  def senior_accidents_index
    @seniors2f = Senior.where(floor: 2).where(using_flg: true).order(:senior_name_call)
    @seniors3f = Senior.where(floor: 3).where(using_flg: true).order(:senior_name_call)
    @seniors4f = Senior.where(floor: 4).where(using_flg: true).order(:senior_name_call)
    @seniors_off = Senior.where(using_flg: false).order(:senior_name_call)
    @accidents2f = Accident.includes(:senior).where(accident_floor: 2).order(accident_datetime: "desc")
    @accidents3f = Accident.includes(:senior).where(accident_floor: 3).order(accident_datetime: "desc")
    @accidents4f = Accident.includes(:senior).where(accident_floor: 4).order(accident_datetime: "desc")
  end

  def new
    @senior = @facility.seniors.find(params[:senior_id])
    @accident = @senior.accidents.new
  end

  def create
    @senior = @facility.seniors.find(params[:senior_id])
    @accident = @senior.accidents.new(accident_params)
    if @accident.save
      flash[:success] = "「#{@senior.senior_name}」さんのヒヤリ・事故報告書を新規作成しました。"
      redirect_to senior_accidents_index_facility_accidents_path
    else
      flash.now[:danger] = "未入力項目があります。再度確認して下さい。"
      @accident = @senior.accidents.new(accident_params)
      render :new
    end
  end

  private

    #ヒヤリ・事故情報
    def accident_params
      params.require(:senior).permit(accidents: [:which_accident, :reporter, :accident_datetime, :accident_time,
                                                 :accident_senior, :accident_scene, :accident_floor])[:accidents]
    end

end
