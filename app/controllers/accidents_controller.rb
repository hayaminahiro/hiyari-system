class AccidentsController < ApplicationController

  before_action :set_facility_id, only: [:index, :show, :new_accidents_index, :new, :create, :edit, :update, :browsing,
                                         #初回捺印
                                         :charge_sign, :reset_charge_sign, :chief_sign, :reset_chief_sign,
                                         :risk_manager_sign, :reset_risk_manager_sign, :director_sign, :reset_director_sign,
                                         :facility_manager_sign, :reset_facility_manager_sign,
                                         #最終捺印
                                         :last_chief_sign, :last_reset_chief_sign,
                                         :last_risk_manager_sign, :last_reset_risk_manager_sign, :last_director_sign, :last_reset_director_sign,
                                         :last_facility_manager_sign, :last_reset_facility_manager,
                                         :month_spreadsheet, :destroy]
  before_action :logged_in_facility, only: [:index, :show, :new_accidents_index, :new, :edit, :spreadsheet,
                                            :month_spreadsheet, :spreadsheet_accidents]
  before_action :correct_facility, only: [:index, :show, :new_accidents_index, :new, :edit, :month_spreadsheet, :edit, :update]
  before_action :set_senior_id, only: [:show, :new, :create, :edit, :update, :browsing, :destroy,
                                       #初回捺印
                                       :charge_sign, :reset_charge_sign, :chief_sign, :reset_chief_sign, :risk_manager_sign, :reset_risk_manager_sign,
                                       :director_sign, :reset_director_sign, :facility_manager_sign, :reset_facility_manager_sign,
                                       #最終捺印
                                       :last_chief_sign, :last_reset_chief_sign, :last_risk_manager_sign, :last_reset_risk_manager_sign,
                                       :last_director_sign, :last_reset_director_sign, :last_facility_manager_sign, :last_reset_facility_manager]
  before_action :set_accident_id, only: [:show, :edit, :update, :browsing, :destroy,
                                         #初回捺印
                                         :charge_sign, :reset_charge_sign, :chief_sign, :reset_chief_sign, :risk_manager_sign, :reset_risk_manager_sign,
                                         :director_sign, :reset_director_sign, :facility_manager_sign, :reset_facility_manager_sign,
                                         #最終捺印
                                         :last_chief_sign, :last_reset_chief_sign,
                                         :last_risk_manager_sign, :last_reset_risk_manager_sign, :last_director_sign, :last_reset_director_sign,
                                         :last_facility_manager_sign, :last_reset_facility_manager]

  before_action :set_seniors, only: [:index, :new_accidents_index]
  before_action :set_accidents, only: [:index, :new_accidents_index, :spreadsheet]
  before_action :set_hat_accident_count, only: [:spreadsheet]
  before_action :set_month, only: [:month_spreadsheet, :spreadsheet_accidents]

  #利用者別ヒヤリ一覧
  def index
  end

  #ヒヤリ印刷画面詳細
  def show
  end

  #ヒヤリ新規作成
  def new_accidents_index
  end

  def new
    @accident = @senior.accidents.new
  end

  def create
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
  end

  def update
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
  end

  #担当印押下
  def charge_sign
    if @senior.workers.present?
      @senior.workers.each do |worker|
        if @accident.update_attributes(charge_sign: worker.sign_name)
          flash[:success] = "#{@accident.accident_datetime.strftime("%Y年%m月%d日")} &emsp; #{@senior.floor}階利用者「#{@senior.senior_name}」さんの担当印を押下しました。"
        end
      end
      if @senior.floor2
        redirect_to @facility
      elsif @senior.floor3
        redirect_to show_3f_facility_url(current_facility)
      elsif @senior.floor4
        redirect_to show_4f_facility_url(current_facility)
      end
    else
      flash[:danger] = "担当職員が登録されていません。職員一覧ページまたは利用者一覧ページから登録して下さい。"
      if @senior.floor2
        redirect_to @facility
      elsif @senior.floor3
        redirect_to show_3f_facility_url(current_facility)
      elsif @senior.floor4
        redirect_to show_4f_facility_url(current_facility)
      end
    end
  end

  #担当印キャンセル
  def reset_charge_sign
    if @accident.update_attributes(charge_sign: nil)
      flash[:warning] = "#{@accident.accident_datetime.strftime("%Y年%m月%d日")} &emsp; #{@senior.floor}階利用者「#{@senior.senior_name}」さんの担当印をキャンセルしました。"
    end
    if @senior.floor2
      redirect_to @facility
    elsif @senior.floor3
      redirect_to show_3f_facility_url(current_facility)
    elsif @senior.floor4
      redirect_to show_4f_facility_url(current_facility)
    end
  end

  #担当係長印押下
  def chief_sign
    chief_2f = Worker.chief_2f[0]
    chief_3f = Worker.chief_3f[0]
    chief_4f = Worker.chief_4f[0]
    if chief_judgment(@accident.floor2, chief_2f)
      if @accident.update_attributes(superior_d: chief_2f.sign_name)
        flash[:success] = "#{@accident.accident_datetime.strftime("%Y年%m月%d日")} &emsp; #{@senior.floor}階利用者「#{@senior.senior_name}」さんの２階係長印を押下しました。"
        redirect_to @facility
      end
    elsif chief_judgment(@accident.floor3, chief_3f)
      if @accident.update_attributes(superior_e: chief_3f.sign_name)
        flash[:success] = "#{@accident.accident_datetime.strftime("%Y年%m月%d日")} &emsp; #{@senior.floor}階利用者「#{@senior.senior_name}」さんの３階係長印を押下しました。"
        redirect_to show_3f_facility_url(current_facility)
      end
    elsif chief_judgment(@accident.floor4, chief_4f)
      if @accident.update_attributes(superior_f: chief_4f.sign_name)
        flash[:success] = "#{@accident.accident_datetime.strftime("%Y年%m月%d日")} &emsp; #{@senior.floor}階利用者「#{@senior.senior_name}」さんの４階係長印を押下しました。"
        redirect_to show_4f_facility_url(current_facility)
      end
    else
      flash[:danger] = "担当係長が登録されていません。職員一覧ページから登録して下さい。"
      if @senior.floor2
        redirect_to @facility
      elsif @senior.floor3
        redirect_to show_3f_facility_url(current_facility)
      elsif @senior.floor4
        redirect_to show_4f_facility_url(current_facility)
      end
    end
  end

  #担当係長印キャンセル
  def reset_chief_sign
    if chief_judgment(@accident.floor2, @accident.superior_d)
      if @accident.update_attributes(superior_d: nil)
        flash[:warning] = "#{@accident.accident_datetime.strftime("%Y年%m月%d日")} &emsp; #{@senior.floor}階利用者「#{@senior.senior_name}」さんの担当係長印をキャンセルしました。"
        redirect_to @facility
      end
    elsif chief_judgment(@accident.floor3, @accident.superior_e)
      if @accident.update_attributes(superior_e: nil)
        flash[:warning] = "#{@accident.accident_datetime.strftime("%Y年%m月%d日")} &emsp; #{@senior.floor}階利用者「#{@senior.senior_name}」さんの担当係長印をキャンセルしました。"
        redirect_to show_3f_facility_url(current_facility)
      end
    elsif chief_judgment(@accident.floor4, @accident.superior_f)
      if @accident.update_attributes(superior_f: nil)
        flash[:warning] = "#{@accident.accident_datetime.strftime("%Y年%m月%d日")} &emsp; #{@senior.floor}階利用者「#{@senior.senior_name}」さんの担当係長印をキャンセルしました。"
        redirect_to show_4f_facility_url(current_facility)
      end
    end
  end

  #リスマネ印押下
  def risk_manager_sign
    risk_manager = Worker.where(position: "リスクマネジャー")[0]
    if risk_manager.present?
      if @accident.update_attributes(superior_c: risk_manager.sign_name)
        flash[:success] = "#{@accident.accident_datetime.strftime("%Y年%m月%d日")} &emsp; #{@senior.floor}階利用者「#{@senior.senior_name}」さんのリスクマネジャー印を押下しました。"
        if @senior.floor2
          redirect_to @facility
        elsif @senior.floor3
          redirect_to show_3f_facility_url(current_facility)
        elsif @senior.floor4
          redirect_to show_4f_facility_url(current_facility)
        end
      end
    else
      flash[:danger] = "リスクマネジャーが登録されていません。職員一覧ページから登録して下さい。"
      if @senior.floor2
        redirect_to @facility
      elsif @senior.floor3
        redirect_to show_3f_facility_url(current_facility)
      elsif @senior.floor4
        redirect_to show_4f_facility_url(current_facility)
      end
    end
  end

  #リスマネ印キャンセル
  def reset_risk_manager_sign
    if @accident.superior_c.present?
      if @accident.update_attributes(superior_c: nil)
        flash[:warning] = "#{@accident.accident_datetime.strftime("%Y年%m月%d日")} &emsp; #{@senior.floor}階利用者「#{@senior.senior_name}」さんのリスクマネジャー印をキャンセルしました。"
        if @senior.floor2
          redirect_to @facility
        elsif @senior.floor3
          redirect_to show_3f_facility_url(current_facility)
        elsif @senior.floor4
          redirect_to show_4f_facility_url(current_facility)
        end
      end
    end
  end

  #次長印押下
  def director_sign
    director = Worker.where(position: "次長")[0]
    if director.present?
      if @accident.update_attributes(superior_b: director.sign_name)
        flash[:success] = "#{@accident.accident_datetime.strftime("%Y年%m月%d日")} &emsp; #{@senior.floor}階利用者「#{@senior.senior_name}」さんの次長印を押下しました。"
        if @senior.floor2
          redirect_to @facility
        elsif @senior.floor3
          redirect_to show_3f_facility_url(current_facility)
        elsif @senior.floor4
          redirect_to show_4f_facility_url(current_facility)
        end
      end
    else
      flash[:danger] = "次長が登録されていません。職員一覧ページから登録して下さい。"
      if @senior.floor2
        redirect_to @facility
      elsif @senior.floor3
        redirect_to show_3f_facility_url(current_facility)
      elsif @senior.floor4
        redirect_to show_4f_facility_url(current_facility)
      end
    end
  end

  #次長印キャンセル
  def reset_director_sign
    if @accident.superior_b.present?
      if @accident.update_attributes(superior_b: nil)
        flash[:warning] = "#{@accident.accident_datetime.strftime("%Y年%m月%d日")} &emsp; #{@senior.floor}階利用者「#{@senior.senior_name}」さんの次長印をキャンセルしました。"
        if @senior.floor2
          redirect_to @facility
        elsif @senior.floor3
          redirect_to show_3f_facility_url(current_facility)
        elsif @senior.floor4
          redirect_to show_4f_facility_url(current_facility)
        end
      end
    end
  end

  #施設長印押下
  def facility_manager_sign
    manager = Worker.where(position: "施設長")[0]
    if manager.present?
      if @accident.update_attributes(superior_a: manager.sign_name)
        flash[:success] = "#{@accident.accident_datetime.strftime("%Y年%m月%d日")} &emsp; #{@senior.floor}階利用者「#{@senior.senior_name}」さんの施設長印を押下しました。"
        if @senior.floor2
          redirect_to @facility
        elsif @senior.floor3
          redirect_to show_3f_facility_url(current_facility)
        elsif @senior.floor4
          redirect_to show_4f_facility_url(current_facility)
        end
      end
    else
      flash[:danger] = "施設長が登録されていません。職員一覧ページから登録して下さい。"
      if @senior.floor2
        redirect_to @facility
      elsif @senior.floor3
        redirect_to show_3f_facility_url(current_facility)
      elsif @senior.floor4
        redirect_to show_4f_facility_url(current_facility)
      end
    end
  end

  #施設長印キャンセル
  def reset_facility_manager_sign
    if @accident.superior_a.present?
      if @accident.update_attributes(superior_a: nil)
        flash[:warning] = "#{@accident.accident_datetime.strftime("%Y年%m月%d日")} &emsp; #{@senior.floor}階利用者「#{@senior.senior_name}」さんの施設長印をキャンセルしました。"
        if @senior.floor2
          redirect_to @facility
        elsif @senior.floor3
          redirect_to show_3f_facility_url(current_facility)
        elsif @senior.floor4
          redirect_to show_4f_facility_url(current_facility)
        end
      end
    end
  end

  #最終担当係長印押下
  def last_chief_sign
    chief_2f = Worker.chief_2f[0]
    chief_3f = Worker.chief_3f[0]
    chief_4f = Worker.chief_4f[0]
    if chief_judgment(@accident.floor2, chief_2f)
      if @accident.update_attributes(superior_d_last: chief_2f.sign_name)
        flash[:success] = "#{@accident.accident_datetime.strftime("%Y年%m月%d日")} &emsp; #{@senior.floor}階利用者「#{@senior.senior_name}」さんの最終２階係長印を押下しました。"
        redirect_to @facility
      end
    elsif chief_judgment(@accident.floor3, chief_3f)
      if @accident.update_attributes(superior_e_last: chief_3f.sign_name)
        flash[:success] = "#{@accident.accident_datetime.strftime("%Y年%m月%d日")} &emsp; #{@senior.floor}階利用者「#{@senior.senior_name}」さんの最終３階係長印を押下しました。"
        redirect_to show_3f_facility_url(current_facility)
      end
    elsif chief_judgment(@accident.floor4, chief_4f)
      if @accident.update_attributes(superior_f_last: chief_4f.sign_name)
        flash[:success] = "#{@accident.accident_datetime.strftime("%Y年%m月%d日")} &emsp; #{@senior.floor}階利用者「#{@senior.senior_name}」さんの最終４階係長印を押下しました。"
        redirect_to show_4f_facility_url(current_facility)
      end
    else
      flash[:danger] = "担当係長が登録されていません。職員一覧ページから登録して下さい。"
      if @senior.floor2
        redirect_to @facility
      elsif @senior.floor3
        redirect_to show_3f_facility_url(current_facility)
      elsif @senior.floor4
        redirect_to show_4f_facility_url(current_facility)
      end
    end
  end

  #最終担当係長印キャンセル
  def last_reset_chief_sign
    if chief_judgment(@accident.floor2, @accident.superior_d_last)
      if @accident.update_attributes(superior_d_last: nil)
        flash[:warning] = "#{@accident.accident_datetime.strftime("%Y年%m月%d日")} &emsp; #{@senior.floor}階利用者「#{@senior.senior_name}」さんの最終担当係長印をキャンセルしました。"
        redirect_to @facility
      end
    elsif chief_judgment(@accident.floor3, @accident.superior_e_last)
      if @accident.update_attributes(superior_e_last: nil)
        flash[:warning] = "#{@accident.accident_datetime.strftime("%Y年%m月%d日")} &emsp; #{@senior.floor}階利用者「#{@senior.senior_name}」さんの最終担当係長印をキャンセルしました。"
        redirect_to show_3f_facility_url(current_facility)
      end
    elsif chief_judgment(@accident.floor4, @accident.superior_f_last)
      if @accident.update_attributes(superior_f_last: nil)
        flash[:warning] = "#{@accident.accident_datetime.strftime("%Y年%m月%d日")} &emsp; #{@senior.floor}階利用者「#{@senior.senior_name}」さんの最終担当係長印をキャンセルしました。"
        redirect_to show_4f_facility_url(current_facility)
      end
    end
  end

  #最終リスマネ印押下
  def last_risk_manager_sign
    risk_manager = Worker.where(position: "リスクマネジャー")[0]
    if risk_manager.present?
      if @accident.update_attributes(superior_c_last: risk_manager.sign_name)
        flash[:success] = "#{@accident.accident_datetime.strftime("%Y年%m月%d日")} &emsp; #{@senior.floor}階利用者「#{@senior.senior_name}」さんの最終リスクマネジャー印を押下しました。"
        if @senior.floor2
          redirect_to @facility
        elsif @senior.floor3
          redirect_to show_3f_facility_url(current_facility)
        elsif @senior.floor4
          redirect_to show_4f_facility_url(current_facility)
        end
      end
    else
      flash[:danger] = "リスクマネジャーが登録されていません。職員一覧ページから登録して下さい。"
      if @senior.floor2
        redirect_to @facility
      elsif @senior.floor3
        redirect_to show_3f_facility_url(current_facility)
      elsif @senior.floor4
        redirect_to show_4f_facility_url(current_facility)
      end
    end
  end

  #最終リスマネ印キャンセル
  def last_reset_risk_manager_sign
    if @accident.superior_c_last.present?
      if @accident.update_attributes(superior_c_last: nil)
        flash[:warning] = "#{@accident.accident_datetime.strftime("%Y年%m月%d日")} &emsp; #{@senior.floor}階利用者「#{@senior.senior_name}」さんの最終リスクマネジャー印をキャンセルしました。"
        if @senior.floor2
          redirect_to @facility
        elsif @senior.floor3
          redirect_to show_3f_facility_url(current_facility)
        elsif @senior.floor4
          redirect_to show_4f_facility_url(current_facility)
        end
      end
    end
  end

  #最終次長印押下
  def last_director_sign
    director = Worker.where(position: "次長")[0]
    if director.present?
      if @accident.update_attributes(superior_b_last: director.sign_name)
        flash[:success] = "#{@accident.accident_datetime.strftime("%Y年%m月%d日")} &emsp; #{@senior.floor}階利用者「#{@senior.senior_name}」さんの最終次長印を押下しました。"
        if @senior.floor2
          redirect_to @facility
        elsif @senior.floor3
          redirect_to show_3f_facility_url(current_facility)
        elsif @senior.floor4
          redirect_to show_4f_facility_url(current_facility)
        end
      end
    else
      flash[:danger] = "次長が登録されていません。職員一覧ページから登録して下さい。"
      if @senior.floor2
        redirect_to @facility
      elsif @senior.floor3
        redirect_to show_3f_facility_url(current_facility)
      elsif @senior.floor4
        redirect_to show_4f_facility_url(current_facility)
      end
    end
  end

  #最終次長印キャンセル
  def last_reset_director_sign
    if @accident.superior_b_last.present?
      if @accident.update_attributes(superior_b_last: nil)
        flash[:warning] = "#{@accident.accident_datetime.strftime("%Y年%m月%d日")} &emsp; #{@senior.floor}階利用者「#{@senior.senior_name}」さんの最終次長印をキャンセルしました。"
        if @senior.floor2
          redirect_to @facility
        elsif @senior.floor3
          redirect_to show_3f_facility_url(current_facility)
        elsif @senior.floor4
          redirect_to show_4f_facility_url(current_facility)
        end
      end
    end
  end

  #最終施設長印押下
  def last_facility_manager_sign
    manager = Worker.where(position: "施設長")[0]
    if manager.present?
      if @accident.update_attributes(superior_a_last: manager.sign_name)
        flash[:success] = "#{@accident.accident_datetime.strftime("%Y年%m月%d日")} &emsp; #{@senior.floor}階利用者「#{@senior.senior_name}」さんの最終施設長印を押下しました。"
        if @senior.floor2
          redirect_to @facility
        elsif @senior.floor3
          redirect_to show_3f_facility_url(current_facility)
        elsif @senior.floor4
          redirect_to show_4f_facility_url(current_facility)
        end
      end
    else
      flash[:danger] = "施設長が登録されていません。職員一覧ページから登録して下さい。"
      if @senior.floor2
        redirect_to @facility
      elsif @senior.floor3
        redirect_to show_3f_facility_url(current_facility)
      elsif @senior.floor4
        redirect_to show_4f_facility_url(current_facility)
      end
    end
  end

  #最終施設長印キャンセル
  def last_reset_facility_manager
    if @accident.superior_a_last.present?
      if @accident.update_attributes(superior_a_last: nil)
        flash[:warning] = "#{@accident.accident_datetime.strftime("%Y年%m月%d日")} &emsp; #{@senior.floor}階利用者「#{@senior.senior_name}」さんの最終施設長印をキャンセルしました。"
        if @senior.floor2
          redirect_to @facility
        elsif @senior.floor3
          redirect_to show_3f_facility_url(current_facility)
        elsif @senior.floor4
          redirect_to show_4f_facility_url(current_facility)
        end
      end
    end
  end

  #月別ヒヤリ集計リンク
  def spreadsheet
  end

  #各月別ヒヤリ集計表
  def month_spreadsheet
    #各月のヒヤリ・事故一覧
    hat_accidents = Accident.includes(:senior).date(@month).hat
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
    @total_scene_hat2f_3_7, @total_scene_hat3f_3_7, @total_scene_hat4f_3_7 = Accident.time_division(hat_accidents)

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
    #出来事総合計のヒヤリハット
    @total_hat_accidents2f = total_event(@fall_hat_accidents2f, @missing_hat_accidents2f, @meal_hat_accidents2f,
                                         @medicine_hat_accidents2f, @scratch_hat_accidents2f, @environment_hat_accidents2f,
                                         @info_contact_hat_accidents2f, @personal_info_hat_accidents2f, @lost_hat_accidents2f,
                                         @damage_hat_accidents2f, @money_hat_accidents2f, @medical_care_hat_accidents2f,
                                         @infection_hat_accidents2f, @forget_hat_accidents2f, @other_hat_accidents2f)
    @total_hat_accidents3f = total_event(@fall_hat_accidents3f, @missing_hat_accidents3f, @meal_hat_accidents3f,
                                         @medicine_hat_accidents3f, @scratch_hat_accidents3f, @environment_hat_accidents3f,
                                         @info_contact_hat_accidents3f, @personal_info_hat_accidents3f, @lost_hat_accidents3f,
                                         @damage_hat_accidents3f, @money_hat_accidents3f, @medical_care_hat_accidents3f,
                                         @infection_hat_accidents3f, @forget_hat_accidents3f, @other_hat_accidents3f)
    @total_hat_accidents4f = total_event(@fall_hat_accidents4f, @missing_hat_accidents4f, @meal_hat_accidents4f,
                                         @medicine_hat_accidents4f, @scratch_hat_accidents4f, @environment_hat_accidents4f,
                                         @info_contact_hat_accidents4f, @personal_info_hat_accidents4f, @lost_hat_accidents4f,
                                         @damage_hat_accidents4f, @money_hat_accidents4f, @medical_care_hat_accidents4f,
                                         @infection_hat_accidents4f, @forget_hat_accidents4f, @other_hat_accidents4f)

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
    @total_scene_hat_accidents2f = total_scene(@service_hat_accidents2f, @support_hat_accidents2f, @lunch_hat_accidents2f,
                                               @toilet_hat_accidents2f, @bathing_hat_accidents2f, @other_scene_hat_accidents2f)
    @total_scene_hat_accidents3f = total_scene(@service_hat_accidents3f, @support_hat_accidents3f, @lunch_hat_accidents3f,
                                               @toilet_hat_accidents3f, @bathing_hat_accidents3f, @other_scene_hat_accidents3f)
    @total_scene_hat_accidents4f = total_scene(@service_hat_accidents4f, @support_hat_accidents4f, @lunch_hat_accidents4f,
                                               @toilet_hat_accidents4f, @bathing_hat_accidents4f, @other_scene_hat_accidents4f)
  end

  #各月別事故集計表
  def spreadsheet_accidents
    #各月のヒヤリ・事故一覧
    accidents = Accident.includes(:senior).date(@month).accident
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

    #転倒・転落の事故
    @fall_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).accident.event_fall
    @fall_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).accident.event_fall
    @fall_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).accident.event_fall
    #行方不明・所在不明の事故
    @missing_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).accident.event_missing
    @missing_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).accident.event_missing
    @missing_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).accident.event_missing
    #飲食に関することの事故
    @meal_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).accident.event_meal
    @meal_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).accident.event_meal
    @meal_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).accident.event_meal
    #薬に関することの事故
    @medicine_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).accident.event_medicine
    @medicine_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).accident.event_medicine
    @medicine_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).accident.event_medicine
    #他害・自傷行為の事故
    @scratch_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).accident.event_scratch
    @scratch_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).accident.event_scratch
    @scratch_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).accident.event_scratch
    #環境の事故
    @environment_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).accident.event_environment
    @environment_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).accident.event_environment
    @environment_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).accident.event_environment
    #情報・連絡・報告の事故
    @info_contact_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).accident.event_info_contact
    @info_contact_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).accident.event_info_contact
    @info_contact_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).accident.event_info_contact
    #個人情報・人権の事故
    @personal_info_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).accident.event_personal_info
    @personal_info_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).accident.event_personal_info
    @personal_info_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).accident.event_personal_info
    #紛失の事故
    @lost_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).accident.event_lost
    @lost_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).accident.event_lost
    @lost_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).accident.event_lost
    #器物破損の事故
    @damage_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).accident.event_damage
    @damage_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).accident.event_damage
    @damage_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).accident.event_damage
    #金銭の事故
    @money_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).accident.event_money
    @money_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).accident.event_money
    @money_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).accident.event_money
    #医療的ケアの事故
    @medical_care_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).accident.event_medical_care
    @medical_care_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).accident.event_medical_care
    @medical_care_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).accident.event_medical_care
    #感染症の事故
    @infection_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).accident.event_infection
    @infection_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).accident.event_infection
    @infection_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).accident.event_infection
    #忘れ物・返却忘れの事故
    @forget_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).accident.event_forget
    @forget_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).accident.event_forget
    @forget_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).accident.event_forget
    #その他の事故
    @other_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).accident.event_other
    @other_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).accident.event_other
    @other_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).accident.event_other
    #出来事総合計の事故
    @total_hat_accidents2f = total_event(@fall_hat_accidents2f, @missing_hat_accidents2f, @meal_hat_accidents2f,
                                         @medicine_hat_accidents2f, @scratch_hat_accidents2f, @environment_hat_accidents2f,
                                         @info_contact_hat_accidents2f, @personal_info_hat_accidents2f, @lost_hat_accidents2f,
                                         @damage_hat_accidents2f, @money_hat_accidents2f, @medical_care_hat_accidents2f,
                                         @infection_hat_accidents2f, @forget_hat_accidents2f, @other_hat_accidents2f)
    @total_hat_accidents3f = total_event(@fall_hat_accidents3f, @missing_hat_accidents3f, @meal_hat_accidents3f,
                                         @medicine_hat_accidents3f, @scratch_hat_accidents3f, @environment_hat_accidents3f,
                                         @info_contact_hat_accidents3f, @personal_info_hat_accidents3f, @lost_hat_accidents3f,
                                         @damage_hat_accidents3f, @money_hat_accidents3f, @medical_care_hat_accidents3f,
                                         @infection_hat_accidents3f, @forget_hat_accidents3f, @other_hat_accidents3f)
    @total_hat_accidents4f = total_event(@fall_hat_accidents4f, @missing_hat_accidents4f, @meal_hat_accidents4f,
                                         @medicine_hat_accidents4f, @scratch_hat_accidents4f, @environment_hat_accidents4f,
                                         @info_contact_hat_accidents4f, @personal_info_hat_accidents4f, @lost_hat_accidents4f,
                                         @damage_hat_accidents4f, @money_hat_accidents4f, @medical_care_hat_accidents4f,
                                         @infection_hat_accidents4f, @forget_hat_accidents4f, @other_hat_accidents4f)

    #通所・送迎の事故
    @service_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).accident.activity_service
    @service_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).accident.activity_service
    @service_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).accident.activity_service
    #活動・支援の事故
    @support_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).accident.activity_support
    @support_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).accident.activity_support
    @support_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).accident.activity_support
    #給食・配膳の事故
    @lunch_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).accident.activity_lunch
    @lunch_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).accident.activity_lunch
    @lunch_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).accident.activity_lunch
    #トイレ・排泄の事故
    @toilet_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).accident.activity_toilet
    @toilet_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).accident.activity_toilet
    @toilet_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).accident.activity_toilet
    #入浴の事故
    @bathing_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).accident.activity_bathing
    @bathing_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).accident.activity_bathing
    @bathing_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).accident.activity_bathing
    #その他の事故
    @other_scene_hat_accidents2f = Accident.includes(:senior).floor(2).date(@month).accident.activity_other_scene
    @other_scene_hat_accidents3f = Accident.includes(:senior).floor(3).date(@month).accident.activity_other_scene
    @other_scene_hat_accidents4f = Accident.includes(:senior).floor(4).date(@month).accident.activity_other_scene
    #場面総合計の事故
    @total_scene_hat_accidents2f = total_scene(@service_hat_accidents2f, @support_hat_accidents2f, @lunch_hat_accidents2f,
                                               @toilet_hat_accidents2f, @bathing_hat_accidents2f, @other_scene_hat_accidents2f)
    @total_scene_hat_accidents3f = total_scene(@service_hat_accidents3f, @support_hat_accidents3f, @lunch_hat_accidents3f,
                                               @toilet_hat_accidents3f, @bathing_hat_accidents3f, @other_scene_hat_accidents3f)
    @total_scene_hat_accidents4f = total_scene(@service_hat_accidents4f, @support_hat_accidents4f, @lunch_hat_accidents4f,
                                               @toilet_hat_accidents4f, @bathing_hat_accidents4f, @other_scene_hat_accidents4f)
  end

  #ヒヤリ削除ボタン
  def destroy
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

