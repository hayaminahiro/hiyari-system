class SeniorsController < ApplicationController

  before_action :url_confirmation, only: :index
  before_action :set_facility_id, only: [:index, :new_senior, :create_senior, :edit_senior, :update_senior, :leaving,
                                         :re_entry, :destroy]
  before_action :set_senior, only: [:edit_senior, :update_senior, :leaving, :re_entry, :destroy]

  #施設利用者一覧ページ
  def index
    @seniors2f = Senior.floor(2).using.name_sorted
    @seniors3f = Senior.floor(3).using.name_sorted
    @seniors4f = Senior.floor(4).using.name_sorted
    @seniors_off = Senior.leaving.name_sorted
    @senior_workers = SeniorWorker.all
  end

  #施設利用者新規作成モーダル
  def new_senior
    @senior = Senior.new
    @workers = Worker.working.including_facility
  end

  #施設利用者新規作成
  def create_senior
    @senior = @facility.seniors.new(senior_params)
    if senior_valid?((senior_params)[:senior_name], (senior_params)[:worker_ids])
      @senior.save
      flash[:success] = "利用者「#{@senior.senior_name}」さんを新規登録しました。"
    else
      flash[:danger] = "入力項目に誤りがあります。ふりがなに全角空白と半角英数字は使用できません。担当職員は最大２名までです。"
    end
    redirect_to facility_seniors_url
  end

  #施設利用者編集モーダル
  def edit_senior
    @workers = @facility.workers.working.including_facility
  end

  #施設利用者情報編集
  def update_senior
    if senior_valid?((senior_params)[:senior_name], (senior_params)[:worker_ids])
      @senior.update_attributes(senior_params)
      flash[:success] = "利用者「#{@senior.senior_name}」さんの情報を更新しました。"
    else
      flash[:danger] = "入力項目に誤りがあります。ふりがなに全角空白と半角英数字は使用できません。担当職員は最大２名までです。"
    end
    redirect_to facility_seniors_url
  end

  #施設利用者退所ボタン
  def leaving
    if @senior.update_attributes(using_flg: false)
      flash[:warning] = "利用者「#{@senior.senior_name}」さんを退所へ変更しました。"
    end
    redirect_to facility_seniors_url
  end

  #施設利用者再入所ボタン
  def re_entry
    if @senior.update_attributes(using_flg: true)
      flash[:success] = "利用者「#{@senior.senior_name}」さん（#{@senior.floor}階）を再入所へ変更しました。"
    end
    redirect_to facility_seniors_url
  end

  #施設利用者削除ボタン
  def destroy
    if @senior.destroy
      flash[:warning] = "利用者「#{@senior.senior_name}」さんを削除しました。"
      redirect_to facility_seniors_url
    end
  end

    private

      #施設利用者情報
      def senior_params
        params.require(:senior).permit(:senior_name, :senior_name_call, :floor, :charge_worker, worker_ids: [])
      end

      # beforeアクション

      # 他のユーザーのページをURL上で入力しても拒否
      def url_confirmation
        @facility = Facility.find(params[:facility_id])
        unless @facility.id == current_facility.id
          flash[:danger] = "情報の閲覧・編集はできません。"
          redirect_to root_url
        end
      end

end
