class FacilitiesController < ApplicationController
  def show
    @facilities = Facility.all
    @facility = Facility.find(params[:id])
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
    @facility = Facility.find(params[:id])
  end

  private

    def facility_params
      params.require(:facility).permit(:name, :email, :password, :password_confirmation)
    end

end
