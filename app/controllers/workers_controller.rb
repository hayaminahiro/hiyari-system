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
    @facility = Facility.find(params[:facility_id])
    @worker = Worker.new
  end

  #職員新規作成
  def create_worker
    @facility  = Facility.find(params[:facility_id])
    @worker = @facility.workers.new(worker_params)
    if @worker.save
      flash[:success] = "「#{@worker.worker_name}」職員を新規登録しました。"
    else
      flash[:danger] = "入力項目に誤りがあります。ふりがなに全角空白と半角英数字は使用できません。"
    end
    redirect_to facility_workers_url
  end

  def edit_worker

  end

  def update_worker

  end

  private

    #施設利用者情報
    def worker_params
      params.require(:worker).permit(:worker_name, :worker_name_call, :sign_name, :working_floor, :charge_senior)
    end

end
