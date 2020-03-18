class WorkersController < ApplicationController

  #職員一覧ページ
  def index
    @facility = Facility.find(params[:facility_id])
    @workers2f = Worker.where(working_floor: 2).where(working_flg: true).order(:worker_name_call)
    @workers3f = Worker.where(working_floor: 3).where(working_flg: true).order(:worker_name_call)
    @workers4f = Worker.where(working_floor: 4).where(working_flg: true).order(:worker_name_call)
    @workers_off = Worker.where(working_flg: false).order(:worker_name_call)
  end

end
