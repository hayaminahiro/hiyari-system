class WorkersController < ApplicationController

  before_action :set_facility_id, only: [:index, :new_worker, :create_worker, :edit_worker, :update_worker,
                                         :retirement, :re_employment, :destroy]
  before_action :set_worker_id, only: [:edit_worker, :update_worker, :retirement, :re_employment, :destroy]

  #職員一覧ページ
  def index
    @workers2f = Worker.floor(2).working.workers_sorted
    @workers3f = Worker.floor(3).working.workers_sorted
    @workers4f = Worker.floor(4).working.workers_sorted
    @nurses = Worker.floor(5).working.workers_sorted
    @managers = Worker.floor(6).working.workers_sorted
    @workers_off = Worker.retirement.workers_sorted
  end

  #職員新規作成モーダル
  def new_worker
    @worker = Worker.new
    @seniors = Senior.using.including_facility.current_facility(current_facility)
  end

  #職員新規作成
  def create_worker
    @worker = @facility.workers.new(worker_params)
    if worker_valid?((worker_params)[:worker_name], (worker_params)[:senior_ids])
      @worker.save
      if @worker.working_floor == nil || @worker.sign_name == ""
        flash[:danger] = "未入力項目があります。"
      else
        if @worker.working_floor == 6
          flash[:success] = "管理の「#{@worker.worker_name}」さんを新規登録しました。ふりがなに全角空白と半角英数字は使用している場合は登録されません。"
        elsif @worker.working_floor == 5
          flash[:success] = "医務の「#{@worker.worker_name}」さんを新規登録しました。ふりがなに全角空白と半角英数字は使用している場合は登録されません。"
        else
          flash[:success] = "#{@worker.working_floor}階職員「#{@worker.worker_name}」さんを新規登録しました。ふりがなに全角空白と半角英数字は使用している場合は登録されません。"
        end
      end
    else
      flash[:danger] = "入力項目に誤りがあります。担当職員は最大６名までです。"
    end
    redirect_to facility_workers_url
  end

  #職員情報編集モーダル
  def edit_worker
    @seniors = Senior.using.including_facility.current_facility(current_facility)
  end

  #職員情報更新
  def update_worker
    if worker_valid?((worker_params)[:worker_name], (worker_params)[:senior_ids])
      @worker.update_attributes(worker_params)
      if @worker.sign_name == ""
        flash[:danger] = "サイン名が未入力です。"
      else
        if @worker.working_floor == 6
          flash[:success] = "管理の「#{@worker.worker_name}」さんの情報を更新しました。ふりがなに全角空白と半角英数字は使用している場合は更新されません。"
        elsif @worker.working_floor == 5
          flash[:success] = "医務の「#{@worker.worker_name}」さんの情報を更新しました。ふりがなに全角空白と半角英数字は使用している場合は更新されません。"
        else
          flash[:success] = "#{@worker.working_floor}階職員「#{@worker.worker_name}」さんの情報を更新しました。ふりがなに全角空白と半角英数字は使用している場合は更新されません。"
        end
      end
    else
      flash[:danger] = "入力項目に誤りがあります。担当職員は最大６名までです。"
    end
    redirect_to facility_workers_url
  end

  #職員退職ボタン
  def retirement
    if @worker.update_attributes(working_flg: false)
      if @worker.working_floor == 6
        flash[:warning] = "管理の「#{@worker.worker_name}」さんを退職へ変更しました。退職者一覧を確認して下さい。"
      elsif @worker.working_floor == 5
        flash[:warning] = "医務の「#{@worker.worker_name}」さんを退職へ変更しました。退職者一覧を確認して下さい。"
      else
        flash[:warning] = "#{@worker.working_floor}階職員「#{@worker.worker_name}」さんを退職へ変更しました。退職者一覧を確認して下さい。"
      end
    end
    redirect_to facility_workers_url
  end

  #職員再就業ボタン
  def re_employment
    if @worker.update_attributes(working_flg: true)
      if @worker.working_floor == 6
        flash[:info] = "職員「#{@worker.worker_name}」さんを再就業へ変更しました。管理を確認して下さい。"
      elsif @worker.working_floor == 5
        flash[:info] = "職員「#{@worker.worker_name}」さんを再就業へ変更しました。医務を確認して下さい。"
      else
        flash[:info] = "職員「#{@worker.worker_name}」さんを再就業へ変更しました。#{@worker.working_floor}階を確認して下さい。"
      end
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
