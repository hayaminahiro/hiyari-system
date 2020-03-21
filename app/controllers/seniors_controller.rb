class SeniorsController < ApplicationController
  #before_action :set_facility, only: [:show, :edit, :update, :destroy, :edit_facility_info, :update_facility_info]
  #before_action :logged_in_facility, only: [:index, :show, :edit, :update, :destroy, :edit_facility_info, :update_facility_info]
  before_action :url_confirmation, only: :index

  #施設利用者一覧ページ
  def index
    @facility = Facility.find(params[:facility_id])
    @seniors2f = Senior.where(floor: 2).where(using_flg: true).order(:senior_name_call)
    @seniors3f = Senior.where(floor: 3).where(using_flg: true).order(:senior_name_call)
    @seniors4f = Senior.where(floor: 4).where(using_flg: true).order(:senior_name_call)
    @seniors_off = Senior.where(using_flg: false).order(:senior_name_call)
  end

  #施設利用者新規作成モーダル
  def new_senior
    @facility = Facility.find(params[:facility_id])
    @senior = Senior.new
    @workers = Worker.where(working_flg: true).includes(:facility)
  end

  #施設利用者新規作成
  def create_senior
    @facility  = Facility.find(params[:facility_id])
    @senior = @facility.seniors.new(senior_params)
    #raise
    if @senior.save
      flash[:success] = "利用者「#{@senior.senior_name}」さんを新規登録しました。"
    else
      flash[:danger] = "入力項目に誤りがあります。ふりがなに全角空白と半角英数字は使用できません。"
    end
    redirect_to facility_seniors_url
  end

  #施設利用者編集モーダル
  def edit_senior
    @facility = Facility.find(params[:facility_id])
    @senior = @facility.seniors.find(params[:id])
    @workers = @facility.workers.where(working_flg: true).includes(:facility)
  end

  #施設利用者情報編集
  def update_senior
    @facility = Facility.find(params[:facility_id])
    @senior = @facility.seniors.find(params[:id])
    if @senior.update_attributes(senior_params)
      flash[:success] = "利用者「#{@senior.senior_name}」さんの情報を更新しました。"
    else
      flash[:danger] = "入力項目に誤りがあります。ふりがなに全角空白と半角英数字は使用できません。"
    end
    redirect_to facility_seniors_url
  end

  #施設利用者退所ボタン
  def leaving
    @facility = Facility.find(params[:facility_id])
    @senior = @facility.seniors.find(params[:id])
    if @senior.update_attributes(using_flg: false)
      flash[:warning] = "利用者「#{@senior.senior_name}」さんを退所へ変更しました。"
    end
    redirect_to facility_seniors_url
  end

  #施設利用者再入所ボタン
  def re_entry
    @facility = Facility.find(params[:facility_id])
    @senior = @facility.seniors.find(params[:id])
    if @senior.update_attributes(using_flg: true)
      flash[:success] = "利用者「#{@senior.senior_name}」さん（#{@senior.floor}階）を再入所へ変更しました。"
    end
    redirect_to facility_seniors_url
  end

  #施設利用者削除ボタン
  def destroy
    @facility = Facility.find(params[:facility_id])
    @senior = @facility.seniors.find(params[:id])
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
