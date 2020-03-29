class AccidentsController < ApplicationController

  #月別ヒヤリ・事故ページ /facilities/:facility_id/accidents
  def index
    @accidents2f = Accident.includes(:senior).where(accident_floor: 2).order(accident_datetime: "desc")
    @accidents3f = Accident.includes(:senior).where(accident_floor: 3).order(accident_datetime: "desc")
    @accidents4f = Accident.includes(:senior).where(accident_floor: 4).order(accident_datetime: "desc")
  end

  def new
    @facility = Facility.find(params[:facility_id])
    @accident = Accident.new
  end

  def create
    @facility = Facility.find(params[:facility_id])
    @accident = Accident.new(accident_params)
    if @accident.save
      flash[:success] = "ヒヤリ・事故報告書を新規作成しました。"
      redirect_to @accident
    else
      render :new
    end

  end

  private

    #ヒヤリ・事故情報
    def accident_params
      params.require(:accident).permit(:which_accident, :accident_scene)
    end

end
