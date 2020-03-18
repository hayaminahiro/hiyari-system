class WorkersController < ApplicationController

  #職員一覧ページ
  def index
    @facility = Facility.find(params[:facility_id])
    @workers2f = Worker.where(working_floor: 2).where(working_flg: true).order(:worker_name_call)
    @workers3f = Worker.where(working_floor: 3).where(working_flg: true).order(:worker_name_call)
    @workers4f = Worker.where(working_floor: 4).where(working_flg: true).order(:worker_name_call)
    @workers_off = Worker.where(working_flg: false).order(:worker_name_call)
  end

  #職員新規作成モーダル
  def new_worker
    #@facility = Facility.find(params[:facility_id])
    #@senior = Senior.new
    #@seniors2f = Senior.where(floor: 2).where(using_flg: true)
    #@seniors3f = Senior.where(floor: 3).where(using_flg: true)
    #@seniors4f = Senior.where(floor: 4).where(using_flg: true)
    #@seniors_off = Senior.where(using_flg: false)
  end

  #職員新規作成
  def create_worker
    #@facility  = Facility.find(params[:facility_id])
    #@senior = @facility.seniors.new(senior_params)
    #@seniors2f = Senior.where(floor: 2).where(using_flg: true)
    #@seniors3f = Senior.where(floor: 3).where(using_flg: true)
    #@seniors4f = Senior.where(floor: 4).where(using_flg: true)
    #@seniors_off = Senior.where(using_flg: false)
    #if @senior.save
    #  flash[:success] = "利用者を新規登録しました。"
    #else
    #  flash[:danger] = "入力項目に誤りがあります。"
    #end
    #redirect_to facility_seniors_url
  end

end
