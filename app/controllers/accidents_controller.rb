class AccidentsController < ApplicationController

  #月別ヒヤリ・事故ページ /facilities/:facility_id/accidents
  def index
    @accidents2f = Accident.includes(:senior).where(accident_floor: 2).order(accident_datetime: "desc")
    @accidents3f = Accident.includes(:senior).where(accident_floor: 3).order(accident_datetime: "desc")
    @accidents4f = Accident.includes(:senior).where(accident_floor: 4).order(accident_datetime: "desc")
  end

  def new
    @facility = Facility.find(params[:facility_id])
    @senior = @facility.seniors.find(params[:senior_id])
  end

  def senior_accidents_index
    @facility = Facility.find(params[:facility_id])
    @seniors2f = Senior.where(floor: 2).where(using_flg: true).order(:senior_name_call)
    @seniors3f = Senior.where(floor: 3).where(using_flg: true).order(:senior_name_call)
    @seniors4f = Senior.where(floor: 4).where(using_flg: true).order(:senior_name_call)
    @seniors_off = Senior.where(using_flg: false).order(:senior_name_call)
    @senior_workers = SeniorWorker.all
    @accidents2f = Accident.includes(:senior).where(accident_floor: 2).order(accident_datetime: "desc")
    @accidents3f = Accident.includes(:senior).where(accident_floor: 3).order(accident_datetime: "desc")
    @accidents4f = Accident.includes(:senior).where(accident_floor: 4).order(accident_datetime: "desc")
  end

  def create
    @facility = Facility.find(params[:facility_id])
    @senior = @facility.seniors.find(params[:senior_id])
    #raise
    @accident = @senior.accidents.new(accident_params)
    #raise
    if @accident.save
      flash[:success] = "ヒヤリ・事故報告書を新規作成しました。"
      redirect_to facility_accidents_url
    else
      flash[:danger] = "aa"
      render :new
    end
  end

  private

    #ヒヤリ・事故情報
    def accident_params
      params.require(:senior).permit(accidents: [:which_accident, :accident_scene])[:accidents]
      #params.require(:article).permit(:title, images_attributes: [:content])
    end

end
