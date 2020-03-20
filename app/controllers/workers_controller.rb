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
      flash[:success] = "職員「#{@worker.worker_name}」さんを新規登録しました。"
    else
      flash[:danger] = "入力項目に誤りがあります。ふりがなに全角空白と半角英数字は使用できません。"
    end
    redirect_to facility_workers_url
  end

  #職員情報編集モーダル
  def edit_worker
    @facility = Facility.find(params[:facility_id])
    @worker = @facility.workers.find(params[:id])
  end

  #職員情報更新
  def update_worker
    @facility = Facility.find(params[:facility_id])
    @worker = @facility.workers.find(params[:id])
    if @worker.update_attributes(worker_params)
      flash[:success] = "職員「#{@worker.worker_name}」さんの情報を更新しました。"
    else
      flash[:danger] = "入力項目に誤りがあります。ふりがなに全角空白と半角英数字は使用できません。"
    end
    redirect_to facility_workers_url
  end

  #職員退職ボタン
  def retirement
    @facility = Facility.find(params[:facility_id])
    @worker = @facility.workers.find(params[:id])
    if @worker.update_attributes(working_flg: false)
      flash[:warning] = "職員「#{@worker.worker_name}」さんを退職へ変更しました。"
    end
    redirect_to facility_workers_url
  end

  #職員再就業ボタン
  def re_employment
    @facility = Facility.find(params[:facility_id])
    @worker = @facility.workers.find(params[:id])
    if @worker.update_attributes(working_flg: true)
      flash[:success] = "職員「#{@worker.worker_name}」さん（#{@worker.working_floor}階）を再就業へ変更しました。"
    end
    redirect_to facility_workers_url
  end

  #職員削除ボタン
  def destroy
    @facility = Facility.find(params[:facility_id])
    @worker = @facility.workers.find(params[:id])
    if @worker.destroy
      flash[:warning] = "職員「#{@worker.worker_name}」さんを削除しました。"
      redirect_to facility_workers_url
    end
  end

  private

    #職員情報
    def worker_params
      params.require(:worker).permit(:worker_name, :worker_name_call, :sign_name, :working_floor)
    end

end
