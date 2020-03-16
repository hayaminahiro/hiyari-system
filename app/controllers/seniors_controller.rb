class SeniorsController < ApplicationController
  #before_action :set_facility, only: [:show, :edit, :update, :destroy, :edit_facility_info, :update_facility_info]
  #before_action :logged_in_facility, only: [:index, :show, :edit, :update, :destroy, :edit_facility_info, :update_facility_info]

  def index
    @seniors = Senior.all.includes(:facility)
    @seniors2f = Senior.where(floor: "2階").where(using_flg: true)
    @seniors3f = Senior.where(floor: "3階").where(using_flg: true)
    @seniors4f = Senior.where(floor: "4階").where(using_flg: true)
    @seniors_off = Senior.where(using_flg: false)
  end

  def new
  end

  def create
  end



  def new_senior
    @facility = Facility.find(params[:facility_id])
    @senior = Senior.new
  end

  def create_senior
    @facility  = Facility.find(params[:facility_id])
    @senior = @facility.seniors.new(senior_params)
    if @senior.save
      flash[:success] = "利用者を新規登録しました。"
      redirect_to facility_seniors_url
    else
      render :index
    end
  end

  private

    def senior_params
      params.require(:senior).permit(:senior_name, :floor, :charge_worker, :using_flg)
    end

end
