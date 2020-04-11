class AccidentsController < ApplicationController

  before_action :set_facility_id, only: [:index, :show, :new_accidents_index, :new, :create]
  #before_action :logged_in_facility, only: [:index, :edit, :update, :destroy, :edit_facility_info, :update_facility_info]
  #before_action :correct_facility, only: [:edit, :update]
  #before_action :admin_facility, only: [:destroy, :edit_facility_info, :update_facility_info]

  #利用者別ヒヤリ一覧
  def index
    @seniors2f = Senior.where(floor: 2).where(using_flg: true).order(:senior_name_call)
    @seniors3f = Senior.where(floor: 3).where(using_flg: true).order(:senior_name_call)
    @seniors4f = Senior.where(floor: 4).where(using_flg: true).order(:senior_name_call)
    @accidents2f = Accident.includes(:senior).where(accident_floor: 2).order(accident_datetime: "desc")
    @accidents3f = Accident.includes(:senior).where(accident_floor: 3).order(accident_datetime: "desc")
    @accidents4f = Accident.includes(:senior).where(accident_floor: 4).order(accident_datetime: "desc")
  end

  #月別ヒヤリ一覧
  def show
    @senior = @facility.seniors.find(params[:senior_id])
    @accident = @senior.accidents.find(params[:id])
  end

  #ヒヤリ新規作成
  def new_accidents_index
    @seniors2f = Senior.where(floor: 2).where(using_flg: true).order(:senior_name_call)
    @seniors3f = Senior.where(floor: 3).where(using_flg: true).order(:senior_name_call)
    @seniors4f = Senior.where(floor: 4).where(using_flg: true).order(:senior_name_call)
    @accidents2f = Accident.includes(:senior).where(accident_floor: 2).order(accident_datetime: "desc")
    @accidents3f = Accident.includes(:senior).where(accident_floor: 3).order(accident_datetime: "desc")
    @accidents4f = Accident.includes(:senior).where(accident_floor: 4).order(accident_datetime: "desc")
  end

  def new
    @senior = @facility.seniors.find(params[:senior_id])
    @accident = @senior.accidents.new
    #@workers = Worker.all.where(working_flg: true).order(:worker_name_call).map { |worker| [worker.worker_name, worker.worker_name] }
    #Worker.where(working_floor: 2).where(working_flg: true).order(:worker_name_call)
  end

  def create
    @senior = @facility.seniors.find(params[:senior_id])
    @accident = @senior.accidents.new(accident_params)
    if @accident.save
      flash[:success] = "「#{@senior.senior_name}」さん（#{@accident.accident_floor}階）の#{@accident.which_accident}報告書を新規作成しました。"
      redirect_to facility_accidents_path
    else
      flash.now[:danger] = "未入力項目があります。再度確認して下さい。"
      @accident = @senior.accidents.new(accident_params)
      render :new
    end
  end

  private

    #ヒヤリ・事故情報
    def accident_params
      params.require(:senior).permit(accidents: [
          #table外
          :which_accident, :reporting_date, :last_reporting_date, :department, :reporter,
          #具体的内容
          :accident_datetime, :accident_time, :accident_floor, :accident_worker, :accident_place, :active,
          :accident_scene, :accident_result, :accident_result_comment,
          #場面、出来事の領域別分類
          :activity_scene, :event_classification, :other_event,
          #原因・対策・効果等
          :result_comment, :result_worker, :result_senior, :measures_comment, :measures, :change_measures_comment,
          #評価・結果
          :evaluation_date, :evaluation_comment, :measures_result, :superior_comment,
          #発生直後サイン
          :superior_a, :superior_b, :superior_c, :superior_d, :charge_sign, :family_comment,
          #周知後サイン
          :superior_a_last, :superior_b_last, :superior_c_last, :superior_d_last
      ])[:accidents]
    end

end

