class WorkersController < ApplicationController

  before_action :set_facility_id, only: [:index, :new_worker, :create_worker, :edit_worker, :update_worker,
                                         :retirement, :re_employment, :destroy]
  before_action :set_worker_id, only: [:edit_worker, :update_worker, :retirement, :re_employment, :destroy]

  #職員一覧ページ
  def index
    @workers2f = Worker.floor(2).working.workers_sorted
    @workers3f = Worker.floor(3).working.workers_sorted
    @workers4f = Worker.floor(4).working.workers_sorted
    @workers_off = Worker.retirement.workers_sorted
  end

  #職員新規作成モーダル
  def new_worker
    @worker = Worker.new
    @seniors = Senior.using.including_facility
  end

  #職員新規作成
  def create_worker
    @worker = @facility.workers.new(worker_params)
    if worker_valid?((worker_params)[:worker_name], (worker_params)[:senior_ids])
      @worker.save
      flash[:success] = "職員「#{@worker.worker_name}」さんを新規登録しました。ふりがなに全角空白と半角英数字は使用している場合は登録されません。"
    else
      flash[:danger] = "入力項目に誤りがあります。担当職員は最大６名までです。"
    end
    redirect_to facility_workers_url
  end

  #職員情報編集モーダル
  def edit_worker
    @seniors = Senior.using.including_facility
  end

  #職員情報更新
  def update_worker
    if worker_valid?((worker_params)[:worker_name], (worker_params)[:senior_ids])
      @worker.update_attributes(worker_params)
      flash[:success] = "職員「#{@worker.worker_name}」さんの情報を更新しました。ふりがなに全角空白と半角英数字は使用している場合は更新されません。"
    else
      flash[:danger] = "入力項目に誤りがあります。担当職員は最大６名までです。"
    end
    redirect_to facility_workers_url
  end

  #職員退職ボタン
  def retirement
    if @worker.update_attributes(working_flg: false)
      flash[:warning] = "職員「#{@worker.worker_name}」さんを退職へ変更しました。"
    end
    redirect_to facility_workers_url
  end

  #職員再就業ボタン
  def re_employment
    if @worker.update_attributes(working_flg: true)
      flash[:success] = "職員「#{@worker.worker_name}」さん（#{@worker.working_floor}階）を再就業へ変更しました。"
    end
    redirect_to facility_workers_url
  end

  #職員削除ボタン
  def destroy
    if @worker.destroy
      flash[:warning] = "職員「#{@worker.worker_name}」さんを削除しました。"
      redirect_to facility_workers_url
    end
  end

    private

      #職員情報
      def worker_params
        params.require(:worker).permit(:worker_name, :worker_name_call, :sign_name,
                                       :working_floor, :position, senior_ids: [])
      end

end
