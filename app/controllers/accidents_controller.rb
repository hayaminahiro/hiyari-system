class AccidentsController < ApplicationController

  before_action :set_facility_id, only: [:index, :show, :new_accidents_index, :new, :create, :edit, :update, :browsing,
                                         :month_spreadsheet, :destroy]
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

  #ヒヤリ印刷画面詳細
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

  def edit
    @senior = @facility.seniors.find(params[:senior_id])
    @accident = @senior.accidents.find(params[:id])
  end

  def update
    @senior = @facility.seniors.find(params[:senior_id])
    @accident = @senior.accidents.find(params[:id])
    if @accident.update_attributes(accident_params)
      flash[:success] = "ヒヤリ・事故報告書の内容を更新しました。"
      redirect_to facility_senior_accident_path
    else
      flash.now[:danger] = "未入力項目があります。再度確認して下さい。"
      render :edit
    end
  end

  #ヒヤリ閲覧モーダル
  def browsing
    @senior = @facility.seniors.find(params[:senior_id])
    @accident = @senior.accidents.find(params[:id])
  end

  #月別ヒヤリ集計リンク
  def spreadsheet
    @accidents2f = Accident.includes(:senior).where(accident_floor: 2).order(accident_datetime: "desc")
    @accidents3f = Accident.includes(:senior).where(accident_floor: 3).order(accident_datetime: "desc")
    @accidents4f = Accident.includes(:senior).where(accident_floor: 4).order(accident_datetime: "desc")
    @hat_count2f = Accident.includes(:senior).where(accident_floor: 2).where(which_accident: "ヒヤリハット")
    @accident_count2f = Accident.includes(:senior).where(accident_floor: 2).where(which_accident: "事故")
    @hat_count3f = Accident.includes(:senior).where(accident_floor: 3).where(which_accident: "ヒヤリハット")
    @accident_count3f = Accident.includes(:senior).where(accident_floor: 3).where(which_accident: "事故")
    @hat_count4f = Accident.includes(:senior).where(accident_floor: 4).where(which_accident: "ヒヤリハット")
    @accident_count4f = Accident.includes(:senior).where(accident_floor: 4).where(which_accident: "事故")
  end

  #各月別ヒヤリ集計表
  def month_spreadsheet
    #@monthは、各月1日〜月末までを表す。accident_datetimeで使用
    day = params[:month].to_date
    first_day = day.beginning_of_month
    last_day = first_day.end_of_month
    @month = first_day..last_day
    #各月のヒヤリ・事故一覧
    accidents = Accident.includes(:senior).date(@month)
    #Accident.time_division(accidents)からの返り値を、一つ一つViewで使用する為にインスタンス変数に代入
    #time_division(accidents)はAccidentクラスに対して使用するクラスメソッド
    # 転倒・転落
    @fall_hat2f_7_9, @fall_hat3f_7_9, @fall_hat4f_7_9,
    @fall_hat2f_9_12, @fall_hat3f_9_12, @fall_hat4f_9_12,
    @fall_hat2f_12_14, @fall_hat3f_12_14, @fall_hat4f_12_14,
    @fall_hat2f_14_17, @fall_hat3f_14_17, @fall_hat4f_14_17,
    @fall_hat2f_17_19, @fall_hat3f_17_19, @fall_hat4f_17_19,
    @fall_hat2f_19_22, @fall_hat3f_19_22, @fall_hat4f_19_22,
    @fall_hat2f_22_3,  @fall_hat3f_22_3, @fall_hat4f_22_3,
    @fall_hat2f_3_7, @fall_hat3f_3_7, @fall_hat4f_3_7,
    #行方不明・所在不明
    @missing_hat2f_7_9, @missing_hat3f_7_9, @missing_hat4f_7_9,
    @missing_hat2f_9_12, @missing_hat3f_9_12, @missing_hat4f_9_12,
    @missing_hat2f_12_14, @missing_hat3f_12_14, @missing_hat4f_12_14,
    @missing_hat2f_14_17, @missing_hat3f_14_17, @missing_hat4f_14_17,
    @missing_hat2f_17_19, @missing_hat3f_17_19, @missing_hat4f_17_19,
    @missing_hat2f_19_22, @missing_hat3f_19_22, @missing_hat4f_19_22,
    @missing_hat2f_22_3, @missing_hat3f_22_3, @missing_hat4f_22_3,
    @missing_hat2f_3_7, @missing_hat3f_3_7, @missing_hat4f_3_7,
    #飲食に関すること
    @meal_hat2f_7_9, @meal_hat3f_7_9, @meal_hat4f_7_9,
    @meal_hat2f_9_12, @meal_hat3f_9_12, @meal_hat4f_9_12,
    @meal_hat2f_12_14, @meal_hat3f_12_14, @meal_hat4f_12_14,
    @meal_hat2f_14_17, @meal_hat3f_14_17, @meal_hat4f_14_17,
    @meal_hat2f_17_19, @meal_hat3f_17_19, @meal_hat4f_17_19,
    @meal_hat2f_19_22, @meal_hat3f_19_22, @meal_hat4f_19_22,
    @meal_hat2f_22_3,  @meal_hat3f_22_3, @meal_hat4f_22_3,
    @meal_hat2f_3_7, @meal_hat3f_3_7, @meal_hat4f_3_7,
    #薬関係
    @medicine_hat2f_7_9, @medicine_hat3f_7_9, @medicine_hat4f_7_9,
    @medicine_hat2f_9_12, @medicine_hat3f_9_12, @medicine_hat4f_9_12,
    @medicine_hat2f_12_14, @medicine_hat3f_12_14, @medicine_hat4f_12_14,
    @medicine_hat2f_14_17, @medicine_hat3f_14_17, @medicine_hat4f_14_17,
    @medicine_hat2f_17_19, @medicine_hat3f_17_19, @medicine_hat4f_17_19,
    @medicine_hat2f_19_22, @medicine_hat3f_19_22, @medicine_hat4f_19_22,
    @medicine_hat2f_22_3,  @medicine_hat3f_22_3, @medicine_hat4f_22_3,
    @medicine_hat2f_3_7, @medicine_hat3f_3_7, @medicine_hat4f_3_7,
    #他害・自傷行為
    @scratch_hat2f_7_9, @scratch_hat3f_7_9, @scratch_hat4f_7_9,
    @scratch_hat2f_9_12, @scratch_hat3f_9_12, @scratch_hat4f_9_12,
    @scratch_hat2f_12_14, @scratch_hat3f_12_14, @scratch_hat4f_12_14,
    @scratch_hat2f_14_17, @scratch_hat3f_14_17, @scratch_hat4f_14_17,
    @scratch_hat2f_17_19, @scratch_hat3f_17_19, @scratch_hat4f_17_19,
    @scratch_hat2f_19_22, @scratch_hat3f_19_22, @scratch_hat4f_19_22,
    @scratch_hat2f_22_3,  @scratch_hat3f_22_3, @scratch_hat4f_22_3,
    @scratch_hat2f_3_7, @scratch_hat3f_3_7, @scratch_hat4f_3_7,
    #環境
    @environment_hat2f_7_9, @environment_hat3f_7_9, @environment_hat4f_7_9,
    @environment_hat2f_9_12, @environment_hat3f_9_12, @environment_hat4f_9_12,
    @environment_hat2f_12_14, @environment_hat3f_12_14, @environment_hat4f_12_14,
    @environment_hat2f_14_17, @environment_hat3f_14_17, @environment_hat4f_14_17,
    @environment_hat2f_17_19, @environment_hat3f_17_19, @environment_hat4f_17_19,
    @environment_hat2f_19_22, @environment_hat3f_19_22, @environment_hat4f_19_22,
    @environment_hat2f_22_3,  @environment_hat3f_22_3, @environment_hat4f_22_3,
    @environment_hat2f_3_7, @environment_hat3f_3_7, @environment_hat4f_3_7,
    #情報・連絡・報告
    @info_contact_hat2f_7_9, @info_contact_hat3f_7_9, @info_contact_hat4f_7_9,
    @info_contact_hat2f_9_12, @info_contact_hat3f_9_12, @info_contact_hat4f_9_12,
    @info_contact_hat2f_12_14, @info_contact_hat3f_12_14, @info_contact_hat4f_12_14,
    @info_contact_hat2f_14_17, @info_contact_hat3f_14_17, @info_contact_hat4f_14_17,
    @info_contact_hat2f_17_19, @info_contact_hat3f_17_19, @info_contact_hat4f_17_19,
    @info_contact_hat2f_19_22, @info_contact_hat3f_19_22, @info_contact_hat4f_19_22,
    @info_contact_hat2f_22_3,  @info_contact_hat3f_22_3, @info_contact_hat4f_22_3,
    @info_contact_hat2f_3_7, @info_contact_hat3f_3_7, @info_contact_hat4f_3_7,
    #個人情報・人権
    @personal_info_hat2f_7_9, @personal_info_hat3f_7_9, @personal_info_hat4f_7_9,
    @personal_info_hat2f_9_12, @personal_info_hat3f_9_12, @personal_info_hat4f_9_12,
    @personal_info_hat2f_12_14, @personal_info_hat3f_12_14, @personal_info_hat4f_12_14,
    @personal_info_hat2f_14_17, @personal_info_hat3f_14_17, @personal_info_hat4f_14_17,
    @personal_info_hat2f_17_19, @personal_info_hat3f_17_19, @personal_info_hat4f_17_19,
    @personal_info_hat2f_19_22, @personal_info_hat3f_19_22, @personal_info_hat4f_19_22,
    @personal_info_hat2f_22_3,  @personal_info_hat3f_22_3, @personal_info_hat4f_22_3,
    @personal_info_hat2f_3_7, @personal_info_hat3f_3_7, @personal_info_hat4f_3_7,
    #紛失
    @lost_hat2f_7_9, @lost_hat3f_7_9, @lost_hat4f_7_9,
    @lost_hat2f_9_12, @lost_hat3f_9_12, @lost_hat4f_9_12,
    @lost_hat2f_12_14, @lost_hat3f_12_14, @lost_hat4f_12_14,
    @lost_hat2f_14_17, @lost_hat3f_14_17, @lost_hat4f_14_17,
    @lost_hat2f_17_19, @lost_hat3f_17_19, @lost_hat4f_17_19,
    @lost_hat2f_19_22, @lost_hat3f_19_22, @lost_hat4f_19_22,
    @lost_hat2f_22_3,  @lost_hat3f_22_3, @lost_hat4f_22_3,
    @lost_hat2f_3_7, @lost_hat3f_3_7, @lost_hat4f_3_7,
    #器物破損
    @damage_hat2f_7_9, @damage_hat3f_7_9, @damage_hat4f_7_9,
    @damage_hat2f_9_12, @damage_hat3f_9_12, @damage_hat4f_9_12,
    @damage_hat2f_12_14, @damage_hat3f_12_14, @damage_hat4f_12_14,
    @damage_hat2f_14_17, @damage_hat3f_14_17, @damage_hat4f_14_17,
    @damage_hat2f_17_19, @damage_hat3f_17_19, @damage_hat4f_17_19,
    @damage_hat2f_19_22, @damage_hat3f_19_22, @damage_hat4f_19_22,
    @damage_hat2f_22_3, @damage_hat3f_22_3, @damage_hat4f_22_3,
    @damage_hat2f_3_7, @damage_hat3f_3_7, @damage_hat4f_3_7,
    #金銭
    @money_hat2f_7_9, @money_hat3f_7_9, @money_hat4f_7_9,
    @money_hat2f_9_12, @money_hat3f_9_12, @money_hat4f_9_12,
    @money_hat2f_12_14, @money_hat3f_12_14, @money_hat4f_12_14,
    @money_hat2f_14_17, @money_hat3f_14_17, @money_hat4f_14_17,
    @money_hat2f_17_19, @money_hat3f_17_19, @money_hat4f_17_19,
    @money_hat2f_19_22, @money_hat3f_19_22, @money_hat4f_19_22,
    @money_hat2f_22_3, @money_hat3f_22_3, @money_hat4f_22_3,
    @money_hat2f_3_7, @money_hat3f_3_7, @money_hat4f_3_7,
    #医療的ケア
    @medical_care_hat2f_7_9, @medical_care_hat3f_7_9, @medical_care_hat4f_7_9,
    @medical_care_hat2f_9_12, @medical_care_hat3f_9_12, @medical_care_hat4f_9_12,
    @medical_care_hat2f_12_14, @medical_care_hat3f_12_14, @medical_care_hat4f_12_14,
    @medical_care_hat2f_14_17, @medical_care_hat3f_14_17, @medical_care_hat4f_14_17,
    @medical_care_hat2f_17_19, @medical_care_hat3f_17_19, @medical_care_hat4f_17_19,
    @medical_care_hat2f_19_22, @medical_care_hat3f_19_22, @medical_care_hat4f_19_22,
    @medical_care_hat2f_22_3, @medical_care_hat3f_22_3, @medical_care_hat4f_22_3,
    @medical_care_hat2f_3_7, @medical_care_hat3f_3_7, @medical_care_hat4f_3_7,
    #感染症
    @infection_hat2f_7_9, @infection_hat3f_7_9, @infection_hat4f_7_9,
    @infection_hat2f_9_12, @infection_hat3f_9_12, @infection_hat4f_9_12,
    @infection_hat2f_12_14, @infection_hat3f_12_14, @infection_hat4f_12_14,
    @infection_hat2f_14_17, @infection_hat3f_14_17, @infection_hat4f_14_17,
    @infection_hat2f_17_19, @infection_hat3f_17_19, @infection_hat4f_17_19,
    @infection_hat2f_19_22, @infection_hat3f_19_22, @infection_hat4f_19_22,
    @infection_hat2f_22_3, @infection_hat3f_22_3, @infection_hat4f_22_3,
    @infection_hat2f_3_7, @infection_hat3f_3_7, @infection_hat4f_3_7,
    #忘れ物・返却忘れ
    @forget_hat2f_7_9, @forget_hat3f_7_9, @forget_hat4f_7_9,
    @forget_hat2f_9_12, @forget_hat3f_9_12, @forget_hat4f_9_12,
    @forget_hat2f_12_14, @forget_hat3f_12_14, @forget_hat4f_12_14,
    @forget_hat2f_14_17, @forget_hat3f_14_17, @forget_hat4f_14_17,
    @forget_hat2f_17_19, @forget_hat3f_17_19, @forget_hat4f_17_19,
    @forget_hat2f_19_22, @forget_hat3f_19_22, @forget_hat4f_19_22,
    @forget_hat2f_22_3, @forget_hat3f_22_3, @forget_hat4f_22_3,
    @forget_hat2f_3_7, @forget_hat3f_3_7, @forget_hat4f_3_7,
    #その他
    @other_hat2f_7_9, @other_hat3f_7_9, @other_hat4f_7_9,
    @other_hat2f_9_12, @other_hat3f_9_12, @other_hat4f_9_12,
    @other_hat2f_12_14, @other_hat3f_12_14, @other_hat4f_12_14,
    @other_hat2f_14_17, @other_hat3f_14_17, @other_hat4f_14_17,
    @other_hat2f_17_19, @other_hat3f_17_19, @other_hat4f_17_19,
    @other_hat2f_19_22, @other_hat3f_19_22, @other_hat4f_19_22,
    @other_hat2f_22_3, @other_hat3f_22_3, @other_hat4f_22_3,
    @other_hat2f_3_7, @other_hat3f_3_7, @other_hat4f_3_7,
    #総合計
    @total_hat2f_7_9, @total_hat3f_7_9, @total_hat4f_7_9,
    @total_hat2f_9_12, @total_hat3f_9_12, @total_hat4f_9_12,
    @total_hat2f_12_14, @total_hat3f_12_14, @total_hat4f_12_14,
    @total_hat2f_14_17, @total_hat3f_14_17, @total_hat4f_14_17,
    @total_hat2f_17_19, @total_hat3f_17_19, @total_hat4f_17_19,
    @total_hat2f_19_22, @total_hat3f_19_22, @total_hat4f_19_22,
    @total_hat2f_22_3, @total_hat3f_22_3, @total_hat4f_22_3,
    @total_hat2f_3_7, @total_hat3f_3_7, @total_hat4f_3_7,
    #通所・送迎
    @service_hat2f_7_9, @service_hat3f_7_9, @service_hat4f_7_9,
    @service_hat2f_9_12, @service_hat3f_9_12, @service_hat4f_9_12,
    @service_hat2f_12_14, @service_hat3f_12_14, @service_hat4f_12_14,
    @service_hat2f_14_17, @service_hat3f_14_17, @service_hat4f_14_17,
    @service_hat2f_17_19, @service_hat3f_17_19, @service_hat4f_17_19,
    @service_hat2f_19_22, @service_hat3f_19_22, @service_hat4f_19_22,
    @service_hat2f_22_3, @service_hat3f_22_3, @service_hat4f_22_3,
    @service_hat2f_3_7, @service_hat3f_3_7, @service_hat4f_3_7,
    #活動・支援
    @support_hat2f_7_9, @support_hat3f_7_9, @support_hat4f_7_9,
    @support_hat2f_9_12, @support_hat3f_9_12, @support_hat4f_9_12,
    @support_hat2f_12_14, @support_hat3f_12_14, @support_hat4f_12_14,
    @support_hat2f_14_17, @support_hat3f_14_17, @support_hat4f_14_17,
    @support_hat2f_17_19, @support_hat3f_17_19, @support_hat4f_17_19,
    @support_hat2f_19_22, @support_hat3f_19_22, @support_hat4f_19_22,
    @support_hat2f_22_3, @support_hat3f_22_3, @support_hat4f_22_3,
    @support_hat2f_3_7, @support_hat3f_3_7, @support_hat4f_3_7,
    #給食・配膳
    @lunch_hat2f_7_9, @lunch_hat3f_7_9, @lunch_hat4f_7_9,
    @lunch_hat2f_9_12, @lunch_hat3f_9_12, @lunch_hat4f_9_12,
    @lunch_hat2f_12_14, @lunch_hat3f_12_14, @lunch_hat4f_12_14,
    @lunch_hat2f_14_17, @lunch_hat3f_14_17, @lunch_hat4f_14_17,
    @lunch_hat2f_17_19, @lunch_hat3f_17_19, @lunch_hat4f_17_19,
    @lunch_hat2f_19_22, @lunch_hat3f_19_22, @lunch_hat4f_19_22,
    @lunch_hat2f_22_3, @lunch_hat3f_22_3, @lunch_hat4f_22_3,
    @lunch_hat2f_3_7, @lunch_hat3f_3_7, @lunch_hat4f_3_7,
    #トイレ・排泄
    @toilet_hat2f_7_9, @toilet_hat3f_7_9, @toilet_hat4f_7_9,
    @toilet_hat2f_9_12, @toilet_hat3f_9_12, @toilet_hat4f_9_12,
    @toilet_hat2f_12_14, @toilet_hat3f_12_14, @toilet_hat4f_12_14,
    @toilet_hat2f_14_17, @toilet_hat3f_14_17, @toilet_hat4f_14_17,
    @toilet_hat2f_17_19, @toilet_hat3f_17_19, @toilet_hat4f_17_19,
    @toilet_hat2f_19_22, @toilet_hat3f_19_22, @toilet_hat4f_19_22,
    @toilet_hat2f_22_3, @toilet_hat3f_22_3, @toilet_hat4f_22_3,
    @toilet_hat2f_3_7, @toilet_hat3f_3_7, @toilet_hat4f_3_7,
    #入浴
    @bathing_hat2f_7_9, @bathing_hat3f_7_9, @bathing_hat4f_7_9,
    @bathing_hat2f_9_12, @bathing_hat3f_9_12, @bathing_hat4f_9_12,
    @bathing_hat2f_12_14, @bathing_hat3f_12_14, @bathing_hat4f_12_14,
    @bathing_hat2f_14_17, @bathing_hat3f_14_17, @bathing_hat4f_14_17,
    @bathing_hat2f_17_19, @bathing_hat3f_17_19, @bathing_hat4f_17_19,
    @bathing_hat2f_19_22, @bathing_hat3f_19_22, @bathing_hat4f_19_22,
    @bathing_hat2f_22_3, @bathing_hat3f_22_3, @bathing_hat4f_22_3,
    @bathing_hat2f_3_7, @bathing_hat3f_3_7, @bathing_hat4f_3_7,
    #その他
    @other_scene_hat2f_7_9, @other_scene_hat3f_7_9, @other_scene_hat4f_7_9,
    @other_scene_hat2f_9_12, @other_scene_hat3f_9_12, @other_scene_hat4f_9_12,
    @other_scene_hat2f_12_14, @other_scene_hat3f_12_14, @other_scene_hat4f_12_14,
    @other_scene_hat2f_14_17, @other_scene_hat3f_14_17, @other_scene_hat4f_14_17,
    @other_scene_hat2f_17_19, @other_scene_hat3f_17_19, @other_scene_hat4f_17_19,
    @other_scene_hat2f_19_22, @other_scene_hat3f_19_22, @other_scene_hat4f_19_22,
    @other_scene_hat2f_22_3, @other_scene_hat3f_22_3, @other_scene_hat4f_22_3,
    @other_scene_hat2f_3_7, @other_scene_hat3f_3_7, @other_scene_hat4f_3_7,
    #場面総合計
    @total_scene_hat2f_7_9, @total_scene_hat3f_7_9, @total_scene_hat4f_7_9,
    @total_scene_hat2f_9_12, @total_scene_hat3f_9_12, @total_scene_hat4f_9_12,
    @total_scene_hat2f_12_14, @total_scene_hat3f_12_14, @total_scene_hat4f_12_14,
    @total_scene_hat2f_14_17, @total_scene_hat3f_14_17, @total_scene_hat4f_14_17,
    @total_scene_hat2f_17_19, @total_scene_hat3f_17_19, @total_scene_hat4f_17_19,
    @total_scene_hat2f_19_22, @total_scene_hat3f_19_22, @total_scene_hat4f_19_22,
    @total_scene_hat2f_22_3, @total_scene_hat3f_22_3, @total_scene_hat4f_22_3,
    @total_scene_hat2f_3_7, @total_scene_hat3f_3_7, @total_scene_hat4f_3_7 = Accident.time_division(accidents)

    #転倒・転落のヒヤリハット
    @fall_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).hat.event_fall
    @fall_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).hat.event_fall
    @fall_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).hat.event_fall
    #行方不明・所在不明のヒヤリハット
    @missing_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).hat.event_missing
    @missing_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).hat.event_missing
    @missing_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).hat.event_missing
    #飲食に関することのヒヤリハット
    @meal_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).hat.event_meal
    @meal_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).hat.event_meal
    @meal_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).hat.event_meal
    #薬に関することのヒヤリハット
    @medicine_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).hat.event_medicine
    @medicine_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).hat.event_medicine
    @medicine_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).hat.event_medicine
    #他害・自傷行為のヒヤリハット
    @scratch_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).hat.event_scratch
    @scratch_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).hat.event_scratch
    @scratch_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).hat.event_scratch
    #環境のヒヤリハット
    @environment_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).hat.event_environment
    @environment_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).hat.event_environment
    @environment_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).hat.event_environment
    #情報・連絡・報告のヒヤリハット
    @info_contact_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).hat.event_info_contact
    @info_contact_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).hat.event_info_contact
    @info_contact_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).hat.event_info_contact
    #個人情報・人権のヒヤリハット
    @personal_info_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).hat.event_personal_info
    @personal_info_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).hat.event_personal_info
    @personal_info_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).hat.event_personal_info
    #紛失のヒヤリハット
    @lost_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).hat.event_lost
    @lost_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).hat.event_lost
    @lost_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).hat.event_lost
    #器物破損のヒヤリハット
    @damage_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).hat.event_damage
    @damage_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).hat.event_damage
    @damage_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).hat.event_damage
    #金銭のヒヤリハット
    @money_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).hat.event_money
    @money_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).hat.event_money
    @money_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).hat.event_money
    #医療的ケアのヒヤリハット
    @medical_care_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).hat.event_medical_care
    @medical_care_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).hat.event_medical_care
    @medical_care_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).hat.event_medical_care
    #感染症のヒヤリハット
    @infection_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).hat.event_infection
    @infection_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).hat.event_infection
    @infection_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).hat.event_infection
    #忘れ物・返却忘れのヒヤリハット
    @forget_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).hat.event_forget
    @forget_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).hat.event_forget
    @forget_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).hat.event_forget
    #その他のヒヤリハット
    @other_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).hat.event_other
    @other_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).hat.event_other
    @other_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).hat.event_other
    #総合計
    @total_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).hat
    @total_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).hat
    @total_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).hat

    #通所・送迎のヒヤリハット
    @service_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).hat.activity_service
    @service_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).hat.activity_service
    @service_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).hat.activity_service
    #活動・支援のヒヤリハット
    @support_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).hat.activity_support
    @support_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).hat.activity_support
    @support_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).hat.activity_support
    #給食・配膳のヒヤリハット
    @lunch_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).hat.activity_lunch
    @lunch_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).hat.activity_lunch
    @lunch_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).hat.activity_lunch
    #トイレ・排泄のヒヤリハット
    @toilet_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).hat.activity_toilet
    @toilet_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).hat.activity_toilet
    @toilet_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).hat.activity_toilet
    #入浴のヒヤリハット
    @bathing_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).hat.activity_bathing
    @bathing_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).hat.activity_bathing
    @bathing_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).hat.activity_bathing
    #その他のヒヤリハット
    @other_scene_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).hat.activity_other_scene
    @other_scene_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).hat.activity_other_scene
    @other_scene_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).hat.activity_other_scene
    #場面総合計のヒヤリハット
    @total_scene_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).hat
    @total_scene_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).hat
    @total_scene_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).hat
  end

  #ヒヤリ削除ボタン
  def destroy
    @senior = @facility.seniors.find(params[:senior_id])
    @accident = @senior.accidents.find(params[:id])
    if @accident.destroy
      flash[:warning] = "「#{@senior.senior_name}」さんの#{@accident.which_accident}報告書を削除しました。"
      redirect_to facility_accidents_url
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
            :activity_scene, :other_activity_scene, :event_classification, :other_event,
            #原因・対策・効果等
            :result_comment, :measures_comment, :change_measures,
            #評価・結果
            :evaluation_date, :evaluation_comment, :measures_result, :superior_comment,
            #発生直後サイン
            :superior_a, :superior_b, :superior_c, :superior_d, :charge_sign, :family_comment,
            #周知後サイン
            :superior_a_last, :superior_b_last, :superior_c_last, :superior_d_last,
            #複数チェックボックス・・・原因・要因（職員側）
            support_mistake: [], not_enough_skills: [], work_attitude: [], information_sharing_worker: [], not_enough_assessment: [], environment: [],
            #複数チェックボックス・・・原因・要因（利用者側）
            poor_health: [], mental_instability: [], seizure: [], characteristic: [], aging: [],
            #複数チェックボックス・・・改善点
            improved_support: [], understanding_seniors: [], well_known: [], manual_maintenance: [], information_sharing: [],
            worker_education: [], environmental_improvement: [], other: []
        ])[:accidents]
      end

end

