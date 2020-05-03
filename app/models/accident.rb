class Accident < ApplicationRecord
  belongs_to :senior

  validates :which_accident, presence: true
  validates :department, presence: true
  validates :reporter, presence: true
  validates :accident_scene, presence: true

  enum accident_result: {ヒヤリのみ:1, 軽事故等:2}

  enum activity_scene: {
      通所・送迎: 0, 活動・支援（施設内・外出）: 1, 給食・配膳: 2, トイレ・排泄: 3, 入浴: 4, その他: 5
  }, _suffix: true

  enum event_classification: {
      転倒・転落: 0, 行方不明・所在不明: 1, 飲食に関すること: 2, 薬に関すること: 3, 他害・自傷行為: 4,
      環境: 5, 情報・連絡・報告: 6, 個人情報・人権: 7, 紛失: 8, 器物破損: 9, 金銭: 10, 医療的ケア: 11,
      感染症: 12, 忘れ物・返却忘れ: 13, その他: 14
  }, _suffix: true

  enum measures_result: {
      上記対策にて解決: 0, 対策変更にて解決: 1, 未解決: 2, その他: 3
  }, _suffix: true

  #日付
  scope :date, -> (date) { where(accident_datetime: date) }
  #事故発生フロア
  scope :floor, -> (num) { where(accident_floor: num) }
  #ヒヤリor事故
  scope :hat, -> { where(which_accident: "ヒヤリハット") }
  scope :accident, -> { where(which_accident: "事故") }
  # N+1問題
  scope :including_senior, -> { includes(:senior) }
  #日付降順で表示
  scope :accidents_sorted, -> { order(accident_datetime: :desc) }
  #出来事の領域別分類
  scope :event_fall, -> { where(event_classification: 0) }
  scope :event_missing, -> { where(event_classification: 1) }
  scope :event_meal, -> { where(event_classification: 2) }
  scope :event_medicine, -> { where(event_classification: 3) }
  scope :event_scratch, -> { where(event_classification: 4) }
  scope :event_environment, -> { where(event_classification: 5) }
  scope :event_info_contact, -> { where(event_classification: 6) }
  scope :event_personal_info, -> { where(event_classification: 7) }
  scope :event_lost, -> { where(event_classification: 8) }
  scope :event_damage, -> { where(event_classification: 9) }
  scope :event_money, -> { where(event_classification: 10) }
  scope :event_medical_care, -> { where(event_classification: 11) }
  scope :event_infection, -> { where(event_classification: 12) }
  scope :event_forget, -> { where(event_classification: 13) }
  scope :event_other, -> { where(event_classification: 14) }
  #場面・活動状況
  scope :activity_service, -> { where(activity_scene: 0) }
  scope :activity_support, -> { where(activity_scene: 1) }
  scope :activity_lunch, -> { where(activity_scene: 2) }
  scope :activity_toilet, -> { where(activity_scene: 3) }
  scope :activity_bathing, -> { where(activity_scene: 4) }
  scope :activity_other_scene, -> { where(activity_scene: 5) }

  #which_accident（ヒヤリor事故）の選択
  def hat
    "ヒヤリハット" if self.which_accident == "ヒヤリハット"
  end

  def accident
    "事故" if self.which_accident == "事故"
  end

  #accident_floor（利用階）の選択
  def floor2
    2 if self.accident_floor == 2
  end

  def floor3
    3 if self.accident_floor == 3
  end

  def floor4
    4 if self.accident_floor == 4
  end

  #event_classification（出来事の領域的分類）の選択
  def fall
    "転倒・転落" if self.event_classification == "転倒・転落"
  end

  def missing
    "行方不明・所在不明" if self.event_classification == "行方不明・所在不明"
  end

  def meal
    "飲食に関すること" if self.event_classification == "飲食に関すること"
  end

  def medicine
    "薬に関すること" if self.event_classification == "薬に関すること"
  end

  def scratch
    "他害・自傷行為" if self.event_classification == "他害・自傷行為"
  end

  def environment
    "環境" if self.event_classification == "環境"
  end

  def info_contact
    "情報・連絡・報告" if self.event_classification == "情報・連絡・報告"
  end

  def personal_info
    "個人情報・人権" if self.event_classification == "個人情報・人権"
  end

  def lost
    "紛失" if self.event_classification == "紛失"
  end

  def damage
    "器物破損" if self.event_classification == "器物破損"
  end

  def money
    "金銭" if self.event_classification == "金銭"
  end

  def medical_care
    "医療的ケア" if self.event_classification == "医療的ケア"
  end

  def infection
    "感染症" if self.event_classification == "感染症"
  end

  def forget
    "忘れ物・返却忘れ" if self.event_classification == "忘れ物・返却忘れ"
  end

  def other
    "その他" if self.event_classification == "その他"
  end

  #activity_scene（出来事の領域的分類）の選択
  #通所・送迎
  def service
    "通所・送迎" if self.activity_scene == "通所・送迎"
  end

  #活動・支援
  def support
    "活動・支援（施設内・外出）" if self.activity_scene == "活動・支援（施設内・外出）"
  end

  #給食・配膳
  def lunch
    "給食・配膳" if self.activity_scene == "給食・配膳"
  end

  #トイレ・排泄
  def toilet
    "トイレ・排泄" if self.activity_scene == "トイレ・排泄"
  end

  #入浴
  def bathing
    "入浴" if self.activity_scene == "入浴"
  end

  #その他
  def other_scene
    "その他" if self.activity_scene == "その他"
  end

  #出来事総合計
  def self.all_event(hat)
    (hat.fall || hat.missing || hat.meal || hat.medicine || hat.scratch || hat.environment || hat.info_contact ||
        hat.personal_info || hat.lost || hat.damage || hat.money || hat.medical_care || hat.infection || hat.forget || hat.other)
  end

  #場面総合計
  def self.all_scene(hat)
    hat.service || hat.support || hat.lunch || hat.toilet || hat.bathing || hat.other_scene
  end


  #7:00~9:00で時間範囲限定
  def self.time_range_7_9(time)
    time.accident_time.strftime("%k").gsub(" ", "").to_i >= 7 && time.accident_time.strftime("%k").gsub(" ", "").to_i < 9
  end

  #9:00~12:00で時間範囲限定
  def self.time_range_9_12(time)
    time.accident_time.strftime("%k").gsub(" ", "").to_i >= 9 && time.accident_time.strftime("%k").gsub(" ", "").to_i < 12
  end

  #12:00~14:00で時間範囲限定
  def self.time_range_12_14(time)
    time.accident_time.strftime("%k").gsub(" ", "").to_i >= 12 && time.accident_time.strftime("%k").gsub(" ", "").to_i < 14
  end

  #14:00~17:00で時間範囲限定
  def self.time_range_14_17(time)
    time.accident_time.strftime("%k").gsub(" ", "").to_i >= 14 && time.accident_time.strftime("%k").gsub(" ", "").to_i < 17
  end

  #17:00~19:00で時間範囲限定
  def self.time_range_17_19(time)
    time.accident_time.strftime("%k").gsub(" ", "").to_i >= 17 && time.accident_time.strftime("%k").gsub(" ", "").to_i < 19
  end

  #19:00~22:00で時間範囲限定
  def self.time_range_19_22(time)
    time.accident_time.strftime("%k").gsub(" ", "").to_i >= 19 && time.accident_time.strftime("%k").gsub(" ", "").to_i < 22
  end

  #22:00~3:00で時間範囲限定
  def self.time_range_22_3(time)
    time.accident_time.strftime("%k").gsub(" ", "").to_i >= 22 || time.accident_time.strftime("%k").gsub(" ", "").to_i < 3
  end

  #3:00~7:00で時間範囲限定
  def self.time_range_3_7(time)
    time.accident_time.strftime("%k").gsub(" ", "").to_i >= 3 && time.accident_time.strftime("%k").gsub(" ", "").to_i < 7
  end


  def self.time_division(accidents)
    #7~9時の転倒・転落ヒヤリ
    fall_hat2f_7_9 = []
    fall_hat3f_7_9 = []
    fall_hat4f_7_9 = []
    #9~12時の転倒・転落ヒヤリ
    fall_hat2f_9_12 = []
    fall_hat3f_9_12 = []
    fall_hat4f_9_12 = []
    #12~14時の転倒・転落ヒヤリ
    fall_hat2f_12_14 = []
    fall_hat3f_12_14 = []
    fall_hat4f_12_14 = []
    #14~17時の転倒・転落ヒヤリ
    fall_hat2f_14_17 = []
    fall_hat3f_14_17 = []
    fall_hat4f_14_17 = []
    #17~19時の転倒・転落ヒヤリ
    fall_hat2f_17_19 = []
    fall_hat3f_17_19 = []
    fall_hat4f_17_19 = []
    #19~22時の転倒・転落ヒヤリ
    fall_hat2f_19_22 = []
    fall_hat3f_19_22 = []
    fall_hat4f_19_22 = []
    #22~3時の転倒・転落ヒヤリ
    fall_hat2f_22_3 = []
    fall_hat3f_22_3 = []
    fall_hat4f_22_3 = []
    #3~7時の転倒・転落ヒヤリ
    fall_hat2f_3_7 = []
    fall_hat3f_3_7 = []
    fall_hat4f_3_7 = []

    #7~9時の行方不明・所在不明ヒヤリ
    missing_hat2f_7_9 = []
    missing_hat3f_7_9 = []
    missing_hat4f_7_9 = []
    #9~12時の行方不明・所在不明ヒヤリ
    missing_hat2f_9_12 = []
    missing_hat3f_9_12 = []
    missing_hat4f_9_12 = []
    #12~14時の行方不明・所在不明ヒヤリ
    missing_hat2f_12_14 = []
    missing_hat3f_12_14 = []
    missing_hat4f_12_14 = []
    #14~17時の行方不明・所在不明ヒヤリ
    missing_hat2f_14_17 = []
    missing_hat3f_14_17 = []
    missing_hat4f_14_17 = []
    #17~19時の行方不明・所在不明ヒヤリ
    missing_hat2f_17_19 = []
    missing_hat3f_17_19 = []
    missing_hat4f_17_19 = []
    #19~22時の行方不明・所在不明ヒヤリ
    missing_hat2f_19_22 = []
    missing_hat3f_19_22 = []
    missing_hat4f_19_22 = []
    #22~3時の行方不明・所在不明ヒヤリ
    missing_hat2f_22_3 = []
    missing_hat3f_22_3 = []
    missing_hat4f_22_3 = []
    #3~7時の行方不明・所在不明ヒヤリ
    missing_hat2f_3_7 = []
    missing_hat3f_3_7 = []
    missing_hat4f_3_7 = []

    #7~9時の飲食ヒヤリ
    meal_hat2f_7_9 = []
    meal_hat3f_7_9 = []
    meal_hat4f_7_9 = []
    #9~12時の飲食ヒヤリ
    meal_hat2f_9_12 = []
    meal_hat3f_9_12 = []
    meal_hat4f_9_12 = []
    #12~14時の飲食ヒヤリ
    meal_hat2f_12_14 = []
    meal_hat3f_12_14 = []
    meal_hat4f_12_14 = []
    #14~17時の飲食ヒヤリ
    meal_hat2f_14_17 = []
    meal_hat3f_14_17 = []
    meal_hat4f_14_17 = []
    #17~19時の飲食ヒヤリ
    meal_hat2f_17_19 = []
    meal_hat3f_17_19 = []
    meal_hat4f_17_19 = []
    #19~22時の飲食ヒヤリ
    meal_hat2f_19_22 = []
    meal_hat3f_19_22 = []
    meal_hat4f_19_22 = []
    #22~3時の飲食ヒヤリ
    meal_hat2f_22_3 = []
    meal_hat3f_22_3 = []
    meal_hat4f_22_3 = []
    #3~7時の飲食ヒヤリ
    meal_hat2f_3_7 = []
    meal_hat3f_3_7 = []
    meal_hat4f_3_7 = []

    #7~9時の薬関係ヒヤリ
    medicine_hat2f_7_9 = []
    medicine_hat3f_7_9 = []
    medicine_hat4f_7_9 = []
    #9~12時の薬関係ヒヤリ
    medicine_hat2f_9_12 = []
    medicine_hat3f_9_12 = []
    medicine_hat4f_9_12 = []
    #12~14時の薬関係ヒヤリ
    medicine_hat2f_12_14 = []
    medicine_hat3f_12_14 = []
    medicine_hat4f_12_14 = []
    #14~17時の薬関係ヒヤリ
    medicine_hat2f_14_17 = []
    medicine_hat3f_14_17 = []
    medicine_hat4f_14_17 = []
    #17~19時の薬関係ヒヤリ
    medicine_hat2f_17_19 = []
    medicine_hat3f_17_19 = []
    medicine_hat4f_17_19 = []
    #19~22時の薬関係ヒヤリ
    medicine_hat2f_19_22 = []
    medicine_hat3f_19_22 = []
    medicine_hat4f_19_22 = []
    #22~3時の薬関係ヒヤリ
    medicine_hat2f_22_3 = []
    medicine_hat3f_22_3 = []
    medicine_hat4f_22_3 = []
    #3~7時の薬関係ヒヤリ
    medicine_hat2f_3_7 = []
    medicine_hat3f_3_7 = []
    medicine_hat4f_3_7 = []

    #7~9時の他害・自傷行為ヒヤリ
    scratch_hat2f_7_9 = []
    scratch_hat3f_7_9 = []
    scratch_hat4f_7_9 = []
    #9~12時の他害・自傷行為ヒヤリ
    scratch_hat2f_9_12 = []
    scratch_hat3f_9_12 = []
    scratch_hat4f_9_12 = []
    #12~14時の他害・自傷行為ヒヤリ
    scratch_hat2f_12_14 = []
    scratch_hat3f_12_14 = []
    scratch_hat4f_12_14 = []
    #14~17時の他害・自傷行為ヒヤリ
    scratch_hat2f_14_17 = []
    scratch_hat3f_14_17 = []
    scratch_hat4f_14_17 = []
    #17~19時の他害・自傷行為ヒヤリ
    scratch_hat2f_17_19 = []
    scratch_hat3f_17_19 = []
    scratch_hat4f_17_19 = []
    #19~22時の他害・自傷行為ヒヤリ
    scratch_hat2f_19_22 = []
    scratch_hat3f_19_22 = []
    scratch_hat4f_19_22 = []
    #22~3時の他害・自傷行為ヒヤリ
    scratch_hat2f_22_3 = []
    scratch_hat3f_22_3 = []
    scratch_hat4f_22_3 = []
    #3~7時の他害・自傷行為ヒヤリ
    scratch_hat2f_3_7 = []
    scratch_hat3f_3_7 = []
    scratch_hat4f_3_7 = []

    #7~9時の環境ヒヤリ
    environment_hat2f_7_9 = []
    environment_hat3f_7_9 = []
    environment_hat4f_7_9 = []
    #9~12時の環境ヒヤリ
    environment_hat2f_9_12 = []
    environment_hat3f_9_12 = []
    environment_hat4f_9_12 = []
    #12~14時の環境ヒヤリ
    environment_hat2f_12_14 = []
    environment_hat3f_12_14 = []
    environment_hat4f_12_14 = []
    #14~17時の環境ヒヤリ
    environment_hat2f_14_17 = []
    environment_hat3f_14_17 = []
    environment_hat4f_14_17 = []
    #17~19時の環境ヒヤリ
    environment_hat2f_17_19 = []
    environment_hat3f_17_19 = []
    environment_hat4f_17_19 = []
    #19~22時の環境ヒヤリ
    environment_hat2f_19_22 = []
    environment_hat3f_19_22 = []
    environment_hat4f_19_22 = []
    #22~3時の環境ヒヤリ
    environment_hat2f_22_3 = []
    environment_hat3f_22_3 = []
    environment_hat4f_22_3 = []
    #3~7時の環境ヒヤリ
    environment_hat2f_3_7 = []
    environment_hat3f_3_7 = []
    environment_hat4f_3_7 = []

    #7~9時の情報・連絡・報告ヒヤリ
    info_contact_hat2f_7_9 = []
    info_contact_hat3f_7_9 = []
    info_contact_hat4f_7_9 = []
    #9~12時の情報・連絡・報告ヒヤリ
    info_contact_hat2f_9_12 = []
    info_contact_hat3f_9_12 = []
    info_contact_hat4f_9_12 = []
    #12~14時の情報・連絡・報告ヒヤリ
    info_contact_hat2f_12_14 = []
    info_contact_hat3f_12_14 = []
    info_contact_hat4f_12_14 = []
    #14~17時の情報・連絡・報告ヒヤリ
    info_contact_hat2f_14_17 = []
    info_contact_hat3f_14_17 = []
    info_contact_hat4f_14_17 = []
    #17~19時の情報・連絡・報告ヒヤリ
    info_contact_hat2f_17_19 = []
    info_contact_hat3f_17_19 = []
    info_contact_hat4f_17_19 = []
    #19~22時の情報・連絡・報告ヒヤリ
    info_contact_hat2f_19_22 = []
    info_contact_hat3f_19_22 = []
    info_contact_hat4f_19_22 = []
    #22~3時の情報・連絡・報告ヒヤリ
    info_contact_hat2f_22_3 = []
    info_contact_hat3f_22_3 = []
    info_contact_hat4f_22_3 = []
    #3~7時の情報・連絡・報告ヒヤリ
    info_contact_hat2f_3_7 = []
    info_contact_hat3f_3_7 = []
    info_contact_hat4f_3_7 = []

    #7~9時の個人情報・人権ヒヤリ
    personal_info_hat2f_7_9 = []
    personal_info_hat3f_7_9 = []
    personal_info_hat4f_7_9 = []
    #9~12時の個人情報・人権ヒヤリ
    personal_info_hat2f_9_12 = []
    personal_info_hat3f_9_12 = []
    personal_info_hat4f_9_12 = []
    #12~14時の個人情報・人権ヒヤリ
    personal_info_hat2f_12_14 = []
    personal_info_hat3f_12_14 = []
    personal_info_hat4f_12_14 = []
    #14~17時の個人情報・人権ヒヤリ
    personal_info_hat2f_14_17 = []
    personal_info_hat3f_14_17 = []
    personal_info_hat4f_14_17 = []
    #17~19時の個人情報・人権ヒヤリ
    personal_info_hat2f_17_19 = []
    personal_info_hat3f_17_19 = []
    personal_info_hat4f_17_19 = []
    #19~22時の個人情報・人権ヒヤリ
    personal_info_hat2f_19_22 = []
    personal_info_hat3f_19_22 = []
    personal_info_hat4f_19_22 = []
    #22~3時の個人情報・人権ヒヤリ
    personal_info_hat2f_22_3 = []
    personal_info_hat3f_22_3 = []
    personal_info_hat4f_22_3 = []
    #3~7時の個人情報・人権ヒヤリ
    personal_info_hat2f_3_7 = []
    personal_info_hat3f_3_7 = []
    personal_info_hat4f_3_7 = []

    #7~9時の紛失ヒヤリ
    lost_hat2f_7_9 = []
    lost_hat3f_7_9 = []
    lost_hat4f_7_9 = []
    #9~12時の紛失ヒヤリ
    lost_hat2f_9_12 = []
    lost_hat3f_9_12 = []
    lost_hat4f_9_12 = []
    #12~14時の紛失ヒヤリ
    lost_hat2f_12_14 = []
    lost_hat3f_12_14 = []
    lost_hat4f_12_14 = []
    #14~17時の紛失ヒヤリ
    lost_hat2f_14_17 = []
    lost_hat3f_14_17 = []
    lost_hat4f_14_17 = []
    #17~19時の紛失ヒヤリ
    lost_hat2f_17_19 = []
    lost_hat3f_17_19 = []
    lost_hat4f_17_19 = []
    #19~22時の紛失ヒヤリ
    lost_hat2f_19_22 = []
    lost_hat3f_19_22 = []
    lost_hat4f_19_22 = []
    #22~3時の紛失ヒヤリ
    lost_hat2f_22_3 = []
    lost_hat3f_22_3 = []
    lost_hat4f_22_3 = []
    #3~7時の紛失ヒヤリ
    lost_hat2f_3_7 = []
    lost_hat3f_3_7 = []
    lost_hat4f_3_7 = []

    #7~9時の器物破損ヒヤリ
    damage_hat2f_7_9 = []
    damage_hat3f_7_9 = []
    damage_hat4f_7_9 = []
    #9~12時の器物破損ヒヤリ
    damage_hat2f_9_12 = []
    damage_hat3f_9_12 = []
    damage_hat4f_9_12 = []
    #12~14時の器物破損ヒヤリ
    damage_hat2f_12_14 = []
    damage_hat3f_12_14 = []
    damage_hat4f_12_14 = []
    #14~17時の器物破損ヒヤリ
    damage_hat2f_14_17 = []
    damage_hat3f_14_17 = []
    damage_hat4f_14_17 = []
    #17~19時の器物破損ヒヤリ
    damage_hat2f_17_19 = []
    damage_hat3f_17_19 = []
    damage_hat4f_17_19 = []
    #19~22時の器物破損ヒヤリ
    damage_hat2f_19_22 = []
    damage_hat3f_19_22 = []
    damage_hat4f_19_22 = []
    #22~3時の器物破損ヒヤリ
    damage_hat2f_22_3 = []
    damage_hat3f_22_3 = []
    damage_hat4f_22_3 = []
    #3~7時の器物破損ヒヤリ
    damage_hat2f_3_7 = []
    damage_hat3f_3_7 = []
    damage_hat4f_3_7 = []

    #7~9時の金銭ヒヤリ
    money_hat2f_7_9 = []
    money_hat3f_7_9 = []
    money_hat4f_7_9 = []
    #9~12時の金銭ヒヤリ
    money_hat2f_9_12 = []
    money_hat3f_9_12 = []
    money_hat4f_9_12 = []
    #12~14時の金銭ヒヤリ
    money_hat2f_12_14 = []
    money_hat3f_12_14 = []
    money_hat4f_12_14 = []
    #14~17時の金銭ヒヤリ
    money_hat2f_14_17 = []
    money_hat3f_14_17 = []
    money_hat4f_14_17 = []
    #17~19時の金銭ヒヤリ
    money_hat2f_17_19 = []
    money_hat3f_17_19 = []
    money_hat4f_17_19 = []
    #19~22時の金銭ヒヤリ
    money_hat2f_19_22 = []
    money_hat3f_19_22 = []
    money_hat4f_19_22 = []
    #22~3時の金銭ヒヤリ
    money_hat2f_22_3 = []
    money_hat3f_22_3 = []
    money_hat4f_22_3 = []
    #3~7時の金銭ヒヤリ
    money_hat2f_3_7 = []
    money_hat3f_3_7 = []
    money_hat4f_3_7 = []

    #7~9時の医療的ケアのヒヤリ
    medical_care_hat2f_7_9 = []
    medical_care_hat3f_7_9 = []
    medical_care_hat4f_7_9 = []
    #9~12時の医療的ケアのヒヤリ
    medical_care_hat2f_9_12 = []
    medical_care_hat3f_9_12 = []
    medical_care_hat4f_9_12 = []
    #12~14時の医療的ケアのヒヤリ
    medical_care_hat2f_12_14 = []
    medical_care_hat3f_12_14 = []
    medical_care_hat4f_12_14 = []
    #14~17時の医療的ケアのヒヤリ
    medical_care_hat2f_14_17 = []
    medical_care_hat3f_14_17 = []
    medical_care_hat4f_14_17 = []
    #17~19時の医療的ケアのヒヤリ
    medical_care_hat2f_17_19 = []
    medical_care_hat3f_17_19 = []
    medical_care_hat4f_17_19 = []
    #19~22時の医療的ケアのヒヤリ
    medical_care_hat2f_19_22 = []
    medical_care_hat3f_19_22 = []
    medical_care_hat4f_19_22 = []
    #22~3時の医療的ケアのヒヤリ
    medical_care_hat2f_22_3 = []
    medical_care_hat3f_22_3 = []
    medical_care_hat4f_22_3 = []
    #3~7時の医療的ケアのヒヤリ
    medical_care_hat2f_3_7 = []
    medical_care_hat3f_3_7 = []
    medical_care_hat4f_3_7 = []

    #7~9時の感染症ヒヤリ
    infection_hat2f_7_9 = []
    infection_hat3f_7_9 = []
    infection_hat4f_7_9 = []
    #9~12時の感染症ヒヤリ
    infection_hat2f_9_12 = []
    infection_hat3f_9_12 = []
    infection_hat4f_9_12 = []
    #12~14時の感染症ヒヤリ
    infection_hat2f_12_14 = []
    infection_hat3f_12_14 = []
    infection_hat4f_12_14 = []
    #14~17時の感染症ヒヤリ
    infection_hat2f_14_17 = []
    infection_hat3f_14_17 = []
    infection_hat4f_14_17 = []
    #17~19時の感染症ヒヤリ
    infection_hat2f_17_19 = []
    infection_hat3f_17_19 = []
    infection_hat4f_17_19 = []
    #19~22時の感染症ヒヤリ
    infection_hat2f_19_22 = []
    infection_hat3f_19_22 = []
    infection_hat4f_19_22 = []
    #22~3時の感染症ヒヤリ
    infection_hat2f_22_3 = []
    infection_hat3f_22_3 = []
    infection_hat4f_22_3 = []
    #3~7時の感染症ヒヤリ
    infection_hat2f_3_7 = []
    infection_hat3f_3_7 = []
    infection_hat4f_3_7 = []

    #7~9時の忘れ物・返却忘れヒヤリ
    forget_hat2f_7_9 = []
    forget_hat3f_7_9 = []
    forget_hat4f_7_9 = []
    #9~12時の忘れ物・返却忘れヒヤリ
    forget_hat2f_9_12 = []
    forget_hat3f_9_12 = []
    forget_hat4f_9_12 = []
    #12~14時の忘れ物・返却忘れヒヤリ
    forget_hat2f_12_14 = []
    forget_hat3f_12_14 = []
    forget_hat4f_12_14 = []
    #14~17時の忘れ物・返却忘れヒヤリ
    forget_hat2f_14_17 = []
    forget_hat3f_14_17 = []
    forget_hat4f_14_17 = []
    #17~19時の忘れ物・返却忘れヒヤリ
    forget_hat2f_17_19 = []
    forget_hat3f_17_19 = []
    forget_hat4f_17_19 = []
    #19~22時の忘れ物・返却忘れヒヤリ
    forget_hat2f_19_22 = []
    forget_hat3f_19_22 = []
    forget_hat4f_19_22 = []
    #22~3時の忘れ物・返却忘れヒヤリ
    forget_hat2f_22_3 = []
    forget_hat3f_22_3 = []
    forget_hat4f_22_3 = []
    #3~7時の忘れ物・返却忘れヒヤリ
    forget_hat2f_3_7 = []
    forget_hat3f_3_7 = []
    forget_hat4f_3_7 = []

    #7~9時のその他ヒヤリ
    other_hat2f_7_9 = []
    other_hat3f_7_9 = []
    other_hat4f_7_9 = []
    #9~12時のその他ヒヤリ
    other_hat2f_9_12 = []
    other_hat3f_9_12 = []
    other_hat4f_9_12 = []
    #12~14時のその他ヒヤリ
    other_hat2f_12_14 = []
    other_hat3f_12_14 = []
    other_hat4f_12_14 = []
    #14~17時のその他ヒヤリ
    other_hat2f_14_17 = []
    other_hat3f_14_17 = []
    other_hat4f_14_17 = []
    #17~19時のその他ヒヤリ
    other_hat2f_17_19 = []
    other_hat3f_17_19 = []
    other_hat4f_17_19 = []
    #19~22時のその他ヒヤリ
    other_hat2f_19_22 = []
    other_hat3f_19_22 = []
    other_hat4f_19_22 = []
    #22~3時のその他ヒヤリ
    other_hat2f_22_3 = []
    other_hat3f_22_3 = []
    other_hat4f_22_3 = []
    #3~7時のその他ヒヤリ
    other_hat2f_3_7 = []
    other_hat3f_3_7 = []
    other_hat4f_3_7 = []

    #7~9時の総合計ヒヤリ
    total_hat2f_7_9 = []
    total_hat3f_7_9 = []
    total_hat4f_7_9 = []
    #9~12時の総合計ヒヤリ
    total_hat2f_9_12 = []
    total_hat3f_9_12 = []
    total_hat4f_9_12 = []
    #12~14時の総合計ヒヤリ
    total_hat2f_12_14 = []
    total_hat3f_12_14 = []
    total_hat4f_12_14 = []
    #14~17時の総合計ヒヤリ
    total_hat2f_14_17 = []
    total_hat3f_14_17 = []
    total_hat4f_14_17 = []
    #17~19時の総合計ヒヤリ
    total_hat2f_17_19 = []
    total_hat3f_17_19 = []
    total_hat4f_17_19 = []
    #19~22時の総合計ヒヤリ
    total_hat2f_19_22 = []
    total_hat3f_19_22 = []
    total_hat4f_19_22 = []
    #22~3時の総合計ヒヤリ
    total_hat2f_22_3 = []
    total_hat3f_22_3 = []
    total_hat4f_22_3 = []
    #3~7時の総合計ヒヤリ
    total_hat2f_3_7 = []
    total_hat3f_3_7 = []
    total_hat4f_3_7 = []

    #7~9時の通所・送迎ヒヤリ
    service_hat2f_7_9 = []
    service_hat3f_7_9 = []
    service_hat4f_7_9 = []
    #9~12時の通所・送迎ヒヤリ
    service_hat2f_9_12 = []
    service_hat3f_9_12 = []
    service_hat4f_9_12 = []
    #12~14時の通所・送迎ヒヤリ
    service_hat2f_12_14 = []
    service_hat3f_12_14 = []
    service_hat4f_12_14 = []
    #14~17時の通所・送迎ヒヤリ
    service_hat2f_14_17 = []
    service_hat3f_14_17 = []
    service_hat4f_14_17 = []
    #17~19時の通所・送迎ヒヤリ
    service_hat2f_17_19 = []
    service_hat3f_17_19 = []
    service_hat4f_17_19 = []
    #19~22時の通所・送迎ヒヤリ
    service_hat2f_19_22 = []
    service_hat3f_19_22 = []
    service_hat4f_19_22 = []
    #22~3時の通所・送迎ヒヤリ
    service_hat2f_22_3 = []
    service_hat3f_22_3 = []
    service_hat4f_22_3 = []
    #3~7時の通所・送迎ヒヤリ
    service_hat2f_3_7 = []
    service_hat3f_3_7 = []
    service_hat4f_3_7 = []

    #7~9時の活動・支援ヒヤリ
    support_hat2f_7_9 = []
    support_hat3f_7_9 = []
    support_hat4f_7_9 = []
    #9~12時の活動・支援ヒヤリ
    support_hat2f_9_12 = []
    support_hat3f_9_12 = []
    support_hat4f_9_12 = []
    #12~14時の活動・支援ヒヤリ
    support_hat2f_12_14 = []
    support_hat3f_12_14 = []
    support_hat4f_12_14 = []
    #14~17時の活動・支援ヒヤリ
    support_hat2f_14_17 = []
    support_hat3f_14_17 = []
    support_hat4f_14_17 = []
    #17~19時の活動・支援ヒヤリ
    support_hat2f_17_19 = []
    support_hat3f_17_19 = []
    support_hat4f_17_19 = []
    #19~22時の活動・支援ヒヤリ
    support_hat2f_19_22 = []
    support_hat3f_19_22 = []
    support_hat4f_19_22 = []
    #22~3時の活動・支援ヒヤリ
    support_hat2f_22_3 = []
    support_hat3f_22_3 = []
    support_hat4f_22_3 = []
    #3~7時の活動・支援ヒヤリ
    support_hat2f_3_7 = []
    support_hat3f_3_7 = []
    support_hat4f_3_7 = []

    #7~9時の給食・配膳ヒヤリ
    lunch_hat2f_7_9 = []
    lunch_hat3f_7_9 = []
    lunch_hat4f_7_9 = []
    #9~12時の給食・配膳ヒヤリ
    lunch_hat2f_9_12 = []
    lunch_hat3f_9_12 = []
    lunch_hat4f_9_12 = []
    #12~14時の給食・配膳ヒヤリ
    lunch_hat2f_12_14 = []
    lunch_hat3f_12_14 = []
    lunch_hat4f_12_14 = []
    #14~17時の給食・配膳ヒヤリ
    lunch_hat2f_14_17 = []
    lunch_hat3f_14_17 = []
    lunch_hat4f_14_17 = []
    #17~19時の給食・配膳ヒヤリ
    lunch_hat2f_17_19 = []
    lunch_hat3f_17_19 = []
    lunch_hat4f_17_19 = []
    #19~22時の給食・配膳ヒヤリ
    lunch_hat2f_19_22 = []
    lunch_hat3f_19_22 = []
    lunch_hat4f_19_22 = []
    #22~3時の給食・配膳ヒヤリ
    lunch_hat2f_22_3 = []
    lunch_hat3f_22_3 = []
    lunch_hat4f_22_3 = []
    #3~7時の給食・配膳ヒヤリ
    lunch_hat2f_3_7 = []
    lunch_hat3f_3_7 = []
    lunch_hat4f_3_7 = []

    #7~9時のトイレ・排泄ヒヤリ
    toilet_hat2f_7_9 = []
    toilet_hat3f_7_9 = []
    toilet_hat4f_7_9 = []
    #9~12時のトイレ・排泄ヒヤリ
    toilet_hat2f_9_12 = []
    toilet_hat3f_9_12 = []
    toilet_hat4f_9_12 = []
    #12~14時のトイレ・排泄ヒヤリ
    toilet_hat2f_12_14 = []
    toilet_hat3f_12_14 = []
    toilet_hat4f_12_14 = []
    #14~17時のトイレ・排泄ヒヤリ
    toilet_hat2f_14_17 = []
    toilet_hat3f_14_17 = []
    toilet_hat4f_14_17 = []
    #17~19時のトイレ・排泄ヒヤリ
    toilet_hat2f_17_19 = []
    toilet_hat3f_17_19 = []
    toilet_hat4f_17_19 = []
    #19~22時のトイレ・排泄ヒヤリ
    toilet_hat2f_19_22 = []
    toilet_hat3f_19_22 = []
    toilet_hat4f_19_22 = []
    #22~3時のトイレ・排泄ヒヤリ
    toilet_hat2f_22_3 = []
    toilet_hat3f_22_3 = []
    toilet_hat4f_22_3 = []
    #3~7時のトイレ・排泄ヒヤリ
    toilet_hat2f_3_7 = []
    toilet_hat3f_3_7 = []
    toilet_hat4f_3_7 = []

    #7~9時の入浴ヒヤリ
    bathing_hat2f_7_9 = []
    bathing_hat3f_7_9 = []
    bathing_hat4f_7_9 = []
    #9~12時の入浴ヒヤリ
    bathing_hat2f_9_12 = []
    bathing_hat3f_9_12 = []
    bathing_hat4f_9_12 = []
    #12~14時の入浴ヒヤリ
    bathing_hat2f_12_14 = []
    bathing_hat3f_12_14 = []
    bathing_hat4f_12_14 = []
    #14~17時の入浴ヒヤリ
    bathing_hat2f_14_17 = []
    bathing_hat3f_14_17 = []
    bathing_hat4f_14_17 = []
    #17~19時の入浴ヒヤリ
    bathing_hat2f_17_19 = []
    bathing_hat3f_17_19 = []
    bathing_hat4f_17_19 = []
    #19~22時の入浴ヒヤリ
    bathing_hat2f_19_22 = []
    bathing_hat3f_19_22 = []
    bathing_hat4f_19_22 = []
    #22~3時の入浴ヒヤリ
    bathing_hat2f_22_3 = []
    bathing_hat3f_22_3 = []
    bathing_hat4f_22_3 = []
    #3~7時の入浴ヒヤリ
    bathing_hat2f_3_7 = []
    bathing_hat3f_3_7 = []
    bathing_hat4f_3_7 = []

    #7~9時のその他ヒヤリ
    other_scene_hat2f_7_9 = []
    other_scene_hat3f_7_9 = []
    other_scene_hat4f_7_9 = []
    #9~12時のその他ヒヤリ
    other_scene_hat2f_9_12 = []
    other_scene_hat3f_9_12 = []
    other_scene_hat4f_9_12 = []
    #12~14時のその他ヒヤリ
    other_scene_hat2f_12_14 = []
    other_scene_hat3f_12_14 = []
    other_scene_hat4f_12_14 = []
    #14~17時のその他ヒヤリ
    other_scene_hat2f_14_17 = []
    other_scene_hat3f_14_17 = []
    other_scene_hat4f_14_17 = []
    #17~19時のその他ヒヤリ
    other_scene_hat2f_17_19 = []
    other_scene_hat3f_17_19 = []
    other_scene_hat4f_17_19 = []
    #19~22時のその他ヒヤリ
    other_scene_hat2f_19_22 = []
    other_scene_hat3f_19_22 = []
    other_scene_hat4f_19_22 = []
    #22~3時のその他ヒヤリ
    other_scene_hat2f_22_3 = []
    other_scene_hat3f_22_3 = []
    other_scene_hat4f_22_3 = []
    #3~7時のその他ヒヤリ
    other_scene_hat2f_3_7 = []
    other_scene_hat3f_3_7 = []
    other_scene_hat4f_3_7 = []

    #7~9時の場面総合計ヒヤリ
    total_scene_hat2f_7_9 = []
    total_scene_hat3f_7_9 = []
    total_scene_hat4f_7_9 = []
    #9~12時の場面総合計ヒヤリ
    total_scene_hat2f_9_12 = []
    total_scene_hat3f_9_12 = []
    total_scene_hat4f_9_12 = []
    #12~14時の場面総合計ヒヤリ
    total_scene_hat2f_12_14 = []
    total_scene_hat3f_12_14 = []
    total_scene_hat4f_12_14 = []
    #14~17時の場面総合計ヒヤリ
    total_scene_hat2f_14_17 = []
    total_scene_hat3f_14_17 = []
    total_scene_hat4f_14_17 = []
    #17~19時の場面総合計ヒヤリ
    total_scene_hat2f_17_19 = []
    total_scene_hat3f_17_19 = []
    total_scene_hat4f_17_19 = []
    #19~22時の場面総合計ヒヤリ
    total_scene_hat2f_19_22 = []
    total_scene_hat3f_19_22 = []
    total_scene_hat4f_19_22 = []
    #22~3時の場面総合計ヒヤリ
    total_scene_hat2f_22_3 = []
    total_scene_hat3f_22_3 = []
    total_scene_hat4f_22_3 = []
    #3~7時の場面総合計ヒヤリ
    total_scene_hat2f_3_7 = []
    total_scene_hat3f_3_7 = []
    total_scene_hat4f_3_7 = []

    accidents.each do |hat|
      #7~9時の転倒・転落ヒヤリ
      if time_range_7_9(hat) && hat.floor2 && hat.fall
        fall_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && hat.fall
        fall_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && hat.fall
        fall_hat4f_7_9 << hat
      #9~12時の転倒・転落ヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && hat.fall
        fall_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && hat.fall
        fall_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && hat.fall
        fall_hat4f_9_12 << hat
      #12~14時の転倒・転落ヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && hat.fall
        fall_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && hat.fall
        fall_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && hat.fall
        fall_hat4f_12_14 << hat
      #14~17時の転倒・転落ヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && hat.fall
        fall_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && hat.fall
        fall_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && hat.fall
        fall_hat4f_14_17 << hat
      #17~19時の転倒・転落ヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && hat.fall
        fall_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && hat.fall
        fall_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && hat.fall
        fall_hat4f_17_19 << hat
      #19~22時の転倒・転落ヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && hat.fall
        fall_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && hat.fall
        fall_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && hat.fall
        fall_hat4f_19_22 << hat
      #22~3時の転倒・転落ヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && hat.fall
        fall_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && hat.fall
        fall_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && hat.fall
        fall_hat4f_22_3 << hat
      #3~7時の転倒・転落ヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && hat.fall
        fall_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && hat.fall
        fall_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && hat.fall
        fall_hat4f_3_7 << hat
      end

      #7~9時の行方不明・所在不明ヒヤリ
      if time_range_7_9(hat) && hat.floor2 && hat.missing
        missing_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && hat.missing
        missing_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && hat.missing
        missing_hat4f_7_9 << hat
      #9~12時の行方不明・所在不明ヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && hat.missing
        missing_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && hat.missing
        missing_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && hat.missing
        missing_hat4f_9_12 << hat
      #12~14時の行方不明・所在不明ヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && hat.missing
        missing_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && hat.missing
        missing_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && hat.missing
        missing_hat4f_12_14 << hat
      #14~17時の行方不明・所在不明ヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && hat.missing
        missing_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && hat.missing
        missing_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && hat.missing
        missing_hat4f_14_17 << hat
      #17~19時の行方不明・所在不明ヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && hat.missing
        missing_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && hat.missing
        missing_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && hat.missing
        missing_hat4f_17_19 << hat
      #19~22時の行方不明・所在不明ヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && hat.missing
        missing_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && hat.missing
        missing_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && hat.missing
        missing_hat4f_19_22 << hat
      #22~3時の行方不明・所在不明ヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && hat.missing
        missing_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && hat.missing
        missing_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && hat.missing
        missing_hat4f_22_3 << hat
      #3~7時の行方不明・所在不明ヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && hat.missing
        missing_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && hat.missing
        missing_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && hat.missing
        missing_hat4f_3_7 << hat
      end

      #7~9時の飲食に関することヒヤリ
      if time_range_7_9(hat) && hat.floor2 && hat.meal
        meal_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && hat.meal
        meal_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && hat.meal
        meal_hat4f_7_9 << hat
      #9~12時の飲食に関することヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && hat.meal
        meal_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && hat.meal
        meal_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && hat.meal
        meal_hat4f_9_12 << hat
      #12~14時の飲食に関することヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && hat.meal
        meal_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && hat.meal
        meal_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && hat.meal
        meal_hat4f_12_14 << hat
      #14~17時の飲食に関することヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && hat.meal
        meal_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && hat.meal
        meal_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && hat.meal
        meal_hat4f_14_17 << hat
      #17~19時の飲食に関することヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && hat.meal
        meal_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && hat.meal
        meal_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && hat.meal
        meal_hat4f_17_19 << hat
      #19~22時の飲食に関することヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && hat.meal
        meal_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && hat.meal
        meal_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && hat.meal
        meal_hat4f_19_22 << hat
      #22~3時の飲食に関することヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && hat.meal
        meal_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && hat.meal
        meal_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && hat.meal
        meal_hat4f_22_3 << hat
      #3~7時の飲食に関することヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && hat.meal
        meal_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && hat.meal
        meal_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && hat.meal
        meal_hat4f_3_7 << hat
      end

      #7~9時の薬関係ヒヤリ
      if time_range_7_9(hat) && hat.floor2 && hat.medicine
        medicine_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && hat.medicine
        medicine_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && hat.medicine
        medicine_hat4f_7_9 << hat
      #9~12時の薬関係ヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && hat.medicine
        medicine_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && hat.medicine
        medicine_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && hat.medicine
        medicine_hat4f_9_12 << hat
      #12~14時の薬関係ヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && hat.medicine
        medicine_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && hat.medicine
        medicine_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && hat.medicine
        medicine_hat4f_12_14 << hat
      #14~17時の薬関係ヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && hat.medicine
        medicine_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && hat.medicine
        medicine_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && hat.medicine
        medicine_hat4f_14_17 << hat
      #17~19時の薬関係ヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && hat.medicine
        medicine_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && hat.medicine
        medicine_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && hat.medicine
        medicine_hat4f_17_19 << hat
      #19~22時の薬関係ヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && hat.medicine
        medicine_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && hat.medicine
        medicine_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && hat.medicine
        medicine_hat4f_19_22 << hat
      #22~3時の薬関係ヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && hat.medicine
        medicine_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && hat.medicine
        medicine_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && hat.medicine
        medicine_hat4f_22_3 << hat
      #3~7時の薬関係ヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && hat.medicine
        medicine_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && hat.medicine
        medicine_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && hat.medicine
        medicine_hat4f_3_7 << hat
      end

      #7~9時の他害・自傷行為ヒヤリ
      if time_range_7_9(hat) && hat.floor2 && hat.scratch
        scratch_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && hat.scratch
        scratch_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && hat.scratch
        scratch_hat4f_7_9 << hat
      #9~12時の他害・自傷行為ヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && hat.scratch
        scratch_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && hat.scratch
        scratch_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && hat.scratch
        scratch_hat4f_9_12 << hat
      #12~14時の他害・自傷行為ヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && hat.scratch
        scratch_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && hat.scratch
        scratch_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && hat.scratch
        scratch_hat4f_12_14 << hat
      #14~17時の他害・自傷行為ヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && hat.scratch
        scratch_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && hat.scratch
        scratch_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && hat.scratch
        scratch_hat4f_14_17 << hat
      #17~19時の他害・自傷行為ヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && hat.scratch
        scratch_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && hat.scratch
        scratch_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && hat.scratch
        scratch_hat4f_17_19 << hat
      #19~22時の他害・自傷行為ヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && hat.scratch
        scratch_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && hat.scratch
        scratch_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && hat.scratch
        scratch_hat4f_19_22 << hat
      #22~3時の他害・自傷行為ヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && hat.scratch
        scratch_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && hat.scratch
        scratch_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && hat.scratch
        scratch_hat4f_22_3 << hat
      #3~7時の他害・自傷行為ヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && hat.scratch
        scratch_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && hat.scratch
        scratch_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && hat.scratch
        scratch_hat4f_3_7 << hat
      end

      #7~9時の環境ヒヤリ
      if time_range_7_9(hat) && hat.floor2 && hat.environment
        environment_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && hat.environment
        environment_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && hat.environment
        environment_hat4f_7_9 << hat
      #9~12時の環境ヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && hat.environment
        environment_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && hat.environment
        environment_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && hat.environment
        environment_hat4f_9_12 << hat
      #12~14時の環境ヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && hat.environment
        environment_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && hat.environment
        environment_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && hat.environment
        environment_hat4f_12_14 << hat
      #14~17時の環境ヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && hat.environment
        environment_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && hat.environment
        environment_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && hat.environment
        environment_hat4f_14_17 << hat
      #17~19時の環境ヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && hat.environment
        environment_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && hat.environment
        environment_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && hat.environment
        environment_hat4f_17_19 << hat
      #19~22時の環境ヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && hat.environment
        environment_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && hat.environment
        environment_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && hat.environment
        environment_hat4f_19_22 << hat
      #22~3時の環境ヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && hat.environment
        environment_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && hat.environment
        environment_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && hat.environment
        environment_hat4f_22_3 << hat
      #3~7時の環境ヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && hat.environment
        environment_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && hat.environment
        environment_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && hat.environment
        environment_hat4f_3_7 << hat
      end

      #7~9時の情報・連絡・報告ヒヤリ
      if time_range_7_9(hat) && hat.floor2 && hat.info_contact
        info_contact_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && hat.info_contact
        info_contact_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && hat.info_contact
        info_contact_hat4f_7_9 << hat
      #9~12時の情報・連絡・報告ヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && hat.info_contact
        info_contact_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && hat.info_contact
        info_contact_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && hat.info_contact
        info_contact_hat4f_9_12 << hat
      #12~14時の情報・連絡・報告ヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && hat.info_contact
        info_contact_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && hat.info_contact
        info_contact_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && hat.info_contact
        info_contact_hat4f_12_14 << hat
      #14~17時の情報・連絡・報告ヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && hat.info_contact
        info_contact_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && hat.info_contact
        info_contact_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && hat.info_contact
        info_contact_hat4f_14_17 << hat
      #17~19時の情報・連絡・報告ヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && hat.info_contact
        info_contact_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && hat.info_contact
        info_contact_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && hat.info_contact
        info_contact_hat4f_17_19 << hat
      #19~22時の情報・連絡・報告ヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && hat.info_contact
        info_contact_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && hat.info_contact
        info_contact_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && hat.info_contact
        info_contact_hat4f_19_22 << hat
      #22~3時の情報・連絡・報告ヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && hat.info_contact
        info_contact_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && hat.info_contact
        info_contact_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && hat.info_contact
        info_contact_hat4f_22_3 << hat
      #3~7時の情報・連絡・報告ヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && hat.info_contact
        info_contact_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && hat.info_contact
        info_contact_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && hat.info_contact
        info_contact_hat4f_3_7 << hat
      end

      #7~9時の個人情報・人権ヒヤリ
      if time_range_7_9(hat) && hat.floor2 && hat.personal_info
        personal_info_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && hat.personal_info
        personal_info_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && hat.personal_info
        personal_info_hat4f_7_9 << hat
      #9~12時の個人情報・人権ヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && hat.personal_info
        personal_info_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && hat.personal_info
        personal_info_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && hat.personal_info
        personal_info_hat4f_9_12 << hat
      #12~14時の個人情報・人権ヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && hat.personal_info
        personal_info_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && hat.personal_info
        personal_info_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && hat.personal_info
        personal_info_hat4f_12_14 << hat
      #14~17時の個人情報・人権ヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && hat.personal_info
        personal_info_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && hat.personal_info
        personal_info_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && hat.personal_info
        personal_info_hat4f_14_17 << hat
      #17~19時の個人情報・人権ヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && hat.personal_info
        personal_info_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && hat.personal_info
        personal_info_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && hat.personal_info
        personal_info_hat4f_17_19 << hat
      #19~22時の個人情報・人権ヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && hat.personal_info
        personal_info_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && hat.personal_info
        personal_info_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && hat.personal_info
        personal_info_hat4f_19_22 << hat
      #22~3時の個人情報・人権ヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && hat.personal_info
        personal_info_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && hat.personal_info
        personal_info_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && hat.personal_info
        personal_info_hat4f_22_3 << hat
      #3~7時の個人情報・人権ヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && hat.personal_info
        personal_info_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && hat.personal_info
        personal_info_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && hat.personal_info
        personal_info_hat4f_3_7 << hat
      end

      #7~9時の紛失ヒヤリ
      if time_range_7_9(hat) && hat.floor2 && hat.lost
        lost_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && hat.lost
        lost_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && hat.lost
        lost_hat4f_7_9 << hat
      #9~12時の紛失ヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && hat.lost
        lost_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && hat.lost
        lost_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && hat.lost
        lost_hat4f_9_12 << hat
      #12~14時の紛失ヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && hat.lost
        lost_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && hat.lost
        lost_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && hat.lost
        lost_hat4f_12_14 << hat
      #14~17時の紛失ヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && hat.lost
        lost_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && hat.lost
        lost_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && hat.lost
        lost_hat4f_14_17 << hat
      #17~19時の紛失ヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && hat.lost
        lost_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && hat.lost
        lost_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && hat.lost
        lost_hat4f_17_19 << hat
      #19~22時の紛失ヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && hat.lost
        lost_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && hat.lost
        lost_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && hat.lost
        lost_hat4f_19_22 << hat
      #22~3時の紛失ヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && hat.lost
        lost_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && hat.lost
        lost_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && hat.lost
        lost_hat4f_22_3 << hat
      #3~7時の紛失ヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && hat.lost
        lost_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && hat.lost
        lost_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && hat.lost
        lost_hat4f_3_7 << hat
      end

      #7~9時の器物破損ヒヤリ
      if time_range_7_9(hat) && hat.floor2 && hat.damage
        damage_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && hat.damage
        damage_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && hat.damage
        damage_hat4f_7_9 << hat
      #9~12時の器物破損ヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && hat.damage
        damage_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && hat.damage
        damage_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && hat.damage
        damage_hat4f_9_12 << hat
      #12~14時の器物破損ヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && hat.damage
        damage_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && hat.damage
        damage_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && hat.damage
        damage_hat4f_12_14 << hat
      #14~17時の器物破損ヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && hat.damage
        damage_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && hat.damage
        damage_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && hat.damage
        damage_hat4f_14_17 << hat
      #17~19時の器物破損ヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && hat.damage
        damage_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && hat.damage
        damage_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && hat.damage
        damage_hat4f_17_19 << hat
      #19~22時の器物破損ヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && hat.damage
        damage_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && hat.damage
        damage_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && hat.damage
        damage_hat4f_19_22 << hat
      #22~3時の器物破損ヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && hat.damage
        damage_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && hat.damage
        damage_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && hat.damage
        damage_hat4f_22_3 << hat
      #3~7時の器物破損ヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && hat.damage
        damage_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && hat.damage
        damage_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && hat.damage
        damage_hat4f_3_7 << hat
      end

      #7~9時の金銭ヒヤリ
      if time_range_7_9(hat) && hat.floor2 && hat.money
        money_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && hat.money
        money_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && hat.money
        money_hat4f_7_9 << hat
      #9~12時の金銭ヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && hat.money
        money_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && hat.money
        money_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && hat.money
        money_hat4f_9_12 << hat
      #12~14時の金銭ヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && hat.money
        money_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && hat.money
        money_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && hat.money
        money_hat4f_12_14 << hat
      #14~17時の金銭ヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && hat.money
        money_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && hat.money
        money_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && hat.money
        money_hat4f_14_17 << hat
      #17~19時の金銭ヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && hat.money
        money_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && hat.money
        money_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && hat.money
        money_hat4f_17_19 << hat
      #19~22時の金銭ヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && hat.money
        money_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && hat.money
        money_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && hat.money
        money_hat4f_19_22 << hat
      #22~3時の金銭ヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && hat.money
        money_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && hat.money
        money_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && hat.money
        money_hat4f_22_3 << hat
      #3~7時の金銭ヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && hat.money
        money_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && hat.money
        money_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && hat.money
        money_hat4f_3_7 << hat
      end

      #7~9時の医療的ケアのヒヤリ
      if time_range_7_9(hat) && hat.floor2 && hat.medical_care
        medical_care_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && hat.medical_care
        medical_care_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && hat.medical_care
        medical_care_hat4f_7_9 << hat
      #9~12時の医療的ケアのヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && hat.medical_care
        medical_care_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && hat.medical_care
        medical_care_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && hat.medical_care
        medical_care_hat4f_9_12 << hat
      #12~14時の医療的ケアのヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && hat.medical_care
        medical_care_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && hat.medical_care
        medical_care_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && hat.medical_care
        medical_care_hat4f_12_14 << hat
      #14~17時の医療的ケアのヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && hat.medical_care
        medical_care_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && hat.medical_care
        medical_care_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && hat.medical_care
        medical_care_hat4f_14_17 << hat
      #17~19時の医療的ケアのヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && hat.medical_care
        medical_care_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && hat.medical_care
        medical_care_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && hat.medical_care
        medical_care_hat4f_17_19 << hat
      #19~22時の医療的ケアのヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && hat.medical_care
        medical_care_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && hat.medical_care
        medical_care_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && hat.medical_care
        medical_care_hat4f_19_22 << hat
      #22~3時の医療的ケアのヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && hat.medical_care
        medical_care_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && hat.medical_care
        medical_care_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && hat.medical_care
        medical_care_hat4f_22_3 << hat
      #3~7時の医療的ケアのヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && hat.medical_care
        medical_care_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && hat.medical_care
        medical_care_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && hat.medical_care
        medical_care_hat4f_3_7 << hat
      end

      #7~9時の感染症ヒヤリ
      if time_range_7_9(hat) && hat.floor2 && hat.infection
        infection_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && hat.infection
        infection_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && hat.infection
        infection_hat4f_7_9 << hat
      #9~12時の感染症ヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && hat.infection
        infection_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && hat.infection
        infection_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && hat.infection
        infection_hat4f_9_12 << hat
      #12~14時の感染症ヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && hat.infection
        infection_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && hat.infection
        infection_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && hat.infection
        infection_hat4f_12_14 << hat
      #14~17時の感染症ヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && hat.infection
        infection_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && hat.infection
        infection_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && hat.infection
        infection_hat4f_14_17 << hat
      #17~19時の感染症ヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && hat.infection
        infection_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && hat.infection
        infection_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && hat.infection
        infection_hat4f_17_19 << hat
      #19~22時の感染症ヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && hat.infection
        infection_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && hat.infection
        infection_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && hat.infection
        infection_hat4f_19_22 << hat
      #22~3時の感染症ヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && hat.infection
        infection_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && hat.infection
        infection_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && hat.infection
        infection_hat4f_22_3 << hat
      #3~7時の感染症ヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && hat.infection
        infection_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && hat.infection
        infection_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && hat.infection
        infection_hat4f_3_7 << hat
      end

      #7~9時の忘れ物・返却忘れヒヤリ
      if time_range_7_9(hat) && hat.floor2 && hat.forget
        forget_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && hat.forget
        forget_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && hat.forget
        forget_hat4f_7_9 << hat
      #9~12時の忘れ物・返却忘れヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && hat.forget
        forget_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && hat.forget
        forget_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && hat.forget
        forget_hat4f_9_12 << hat
      #12~14時の忘れ物・返却忘れヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && hat.forget
        forget_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && hat.forget
        forget_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && hat.forget
        forget_hat4f_12_14 << hat
      #14~17時の忘れ物・返却忘れヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && hat.forget
        forget_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && hat.forget
        forget_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && hat.forget
        forget_hat4f_14_17 << hat
      #17~19時の忘れ物・返却忘れヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && hat.forget
        forget_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && hat.forget
        forget_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && hat.forget
        forget_hat4f_17_19 << hat
      #19~22時の忘れ物・返却忘れヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && hat.forget
        forget_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && hat.forget
        forget_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && hat.forget
        forget_hat4f_19_22 << hat
      #22~3時の忘れ物・返却忘れヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && hat.forget
        forget_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && hat.forget
        forget_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && hat.forget
        forget_hat4f_22_3 << hat
      #3~7時の忘れ物・返却忘れヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && hat.forget
        forget_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && hat.forget
        forget_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && hat.forget
        forget_hat4f_3_7 << hat
      end

      #7~9時のその他ヒヤリ
      if time_range_7_9(hat) && hat.floor2 && hat.other
        other_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && hat.other
        other_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && hat.other
        other_hat4f_7_9 << hat
      #9~12時のその他ヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && hat.other
        other_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && hat.other
        other_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && hat.other
        other_hat4f_9_12 << hat
      #12~14時のその他ヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && hat.other
        other_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && hat.other
        other_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && hat.other
        other_hat4f_12_14 << hat
      #14~17時のその他ヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && hat.other
        other_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && hat.other
        other_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && hat.other
        other_hat4f_14_17 << hat
      #17~19時のその他ヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && hat.other
        other_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && hat.other
        other_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && hat.other
        other_hat4f_17_19 << hat
      #19~22時のその他ヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && hat.other
        other_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && hat.other
        other_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && hat.other
        other_hat4f_19_22 << hat
      #22~3時のその他ヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && hat.other
        other_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && hat.other
        other_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && hat.other
        other_hat4f_22_3 << hat
      #3~7時のその他ヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && hat.other
        other_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && hat.other
        other_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && hat.other
        other_hat4f_3_7 << hat
      end

      #7~9時の総合計ヒヤリ
      if time_range_7_9(hat) && hat.floor2 && all_event(hat)
        total_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && all_event(hat)
        total_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && all_event(hat)
        total_hat4f_7_9 << hat
      #9~12時の総合計ヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && all_event(hat)
        total_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && all_event(hat)
        total_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && all_event(hat)
        total_hat4f_9_12 << hat
      #12~14時の総合計ヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && all_event(hat)
        total_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && all_event(hat)
        total_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && all_event(hat)
        total_hat4f_12_14 << hat
      #14~17時の総合計ヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && all_event(hat)
        total_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && all_event(hat)
        total_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && all_event(hat)
        total_hat4f_14_17 << hat
      #17~19時の総合計ヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && all_event(hat)
        total_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && all_event(hat)
        total_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && all_event(hat)
        total_hat4f_17_19 << hat
      #19~22時の総合計ヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && all_event(hat)
        total_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && all_event(hat)
        total_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && all_event(hat)
        total_hat4f_19_22 << hat
      #22~3時の総合計ヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && all_event(hat)
        total_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && all_event(hat)
        total_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && all_event(hat)
        total_hat4f_22_3 << hat
      #3~7時の総合計ヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && all_event(hat)
        total_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && all_event(hat)
        total_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && all_event(hat)
        total_hat4f_3_7 << hat
      end

      #7~9時の通所・送迎ヒヤリ
      if time_range_7_9(hat) && hat.floor2 && hat.service
        service_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && hat.service
        service_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && hat.service
        service_hat4f_7_9 << hat
      #9~12時の通所・送迎ヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && hat.service
        service_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && hat.service
        service_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && hat.service
        service_hat4f_9_12 << hat
      #12~14時の通所・送迎ヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && hat.service
        service_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && hat.service
        service_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && hat.service
        service_hat4f_12_14 << hat
      #14~17時の通所・送迎ヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && hat.service
        service_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && hat.service
        service_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && hat.service
        service_hat4f_14_17 << hat
      #17~19時の通所・送迎ヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && hat.service
        service_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && hat.service
        service_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && hat.service
        service_hat4f_17_19 << hat
      #19~22時の通所・送迎ヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && hat.service
        service_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && hat.service
        service_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && hat.service
        service_hat4f_19_22 << hat
      #22~3時の通所・送迎ヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && hat.service
        service_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && hat.service
        service_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && hat.service
        service_hat4f_22_3 << hat
      #3~7時の通所・送迎ヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && hat.service
        service_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && hat.service
        service_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && hat.service
        service_hat4f_3_7 << hat
      end

      #7~9時の活動・支援ヒヤリ
      if time_range_7_9(hat) && hat.floor2 && hat.support
        support_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && hat.support
        support_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && hat.support
        support_hat4f_7_9 << hat
      #9~12時の活動・支援ヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && hat.support
        support_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && hat.support
        support_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && hat.support
        support_hat4f_9_12 << hat
      #12~14時の活動・支援ヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && hat.support
        support_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && hat.support
        support_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && hat.support
        support_hat4f_12_14 << hat
      #14~17時の活動・支援ヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && hat.support
        support_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && hat.support
        support_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && hat.support
        support_hat4f_14_17 << hat
      #17~19時の活動・支援ヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && hat.support
        support_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && hat.support
        support_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && hat.support
        support_hat4f_17_19 << hat
      #19~22時の活動・支援ヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && hat.support
        support_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && hat.support
        support_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && hat.support
        support_hat4f_19_22 << hat
      #22~3時の活動・支援ヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && hat.support
        support_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && hat.support
        support_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && hat.support
        support_hat4f_22_3 << hat
      #3~7時の活動・支援ヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && hat.support
        support_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && hat.support
        support_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && hat.support
        support_hat4f_3_7 << hat
      end

      #7~9時の給食・配膳ヒヤリ
      if time_range_7_9(hat) && hat.floor2 && hat.lunch
        lunch_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && hat.lunch
        lunch_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && hat.lunch
        lunch_hat4f_7_9 << hat
      #9~12時の給食・配膳ヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && hat.lunch
        lunch_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && hat.lunch
        lunch_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && hat.lunch
        lunch_hat4f_9_12 << hat
      #12~14時の給食・配膳ヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && hat.lunch
        lunch_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && hat.lunch
        lunch_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && hat.lunch
        lunch_hat4f_12_14 << hat
      #14~17時の給食・配膳ヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && hat.lunch
        lunch_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && hat.lunch
        lunch_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && hat.lunch
        lunch_hat4f_14_17 << hat
      #17~19時の給食・配膳ヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && hat.lunch
        lunch_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && hat.lunch
        lunch_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && hat.lunch
        lunch_hat4f_17_19 << hat
      #19~22時の給食・配膳ヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && hat.lunch
        lunch_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && hat.lunch
        lunch_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && hat.lunch
        lunch_hat4f_19_22 << hat
      #22~3時の給食・配膳ヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && hat.lunch
        lunch_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && hat.lunch
        lunch_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && hat.lunch
        lunch_hat4f_22_3 << hat
      #3~7時の給食・配膳ヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && hat.lunch
        lunch_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && hat.lunch
        lunch_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && hat.lunch
        lunch_hat4f_3_7 << hat
      end

      #7~9時のトイレ・排泄ヒヤリ
      if time_range_7_9(hat) && hat.floor2 && hat.toilet
        toilet_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && hat.toilet
        toilet_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && hat.toilet
        toilet_hat4f_7_9 << hat
      #9~12時のトイレ・排泄ヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && hat.toilet
        toilet_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && hat.toilet
        toilet_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && hat.toilet
        toilet_hat4f_9_12 << hat
      #12~14時のトイレ・排泄ヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && hat.toilet
        toilet_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && hat.toilet
        toilet_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && hat.toilet
        toilet_hat4f_12_14 << hat
      #14~17時のトイレ・排泄ヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && hat.toilet
        toilet_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && hat.toilet
        toilet_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && hat.toilet
        toilet_hat4f_14_17 << hat
      #17~19時のトイレ・排泄ヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && hat.toilet
        toilet_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && hat.toilet
        toilet_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && hat.toilet
        toilet_hat4f_17_19 << hat
      #19~22時のトイレ・排泄ヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && hat.toilet
        toilet_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && hat.toilet
        toilet_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && hat.toilet
        toilet_hat4f_19_22 << hat
      #22~3時のトイレ・排泄ヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && hat.toilet
        toilet_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && hat.toilet
        toilet_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && hat.toilet
        toilet_hat4f_22_3 << hat
      #3~7時のトイレ・排泄ヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && hat.toilet
        toilet_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && hat.toilet
        toilet_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && hat.toilet
        toilet_hat4f_3_7 << hat
      end

      #7~9時の入浴ヒヤリ
      if time_range_7_9(hat) && hat.floor2 && hat.bathing
        bathing_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && hat.bathing
        bathing_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && hat.bathing
        bathing_hat4f_7_9 << hat
      #9~12時の入浴ヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && hat.bathing
        bathing_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && hat.bathing
        bathing_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && hat.bathing
        bathing_hat4f_9_12 << hat
      #12~14時の入浴ヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && hat.bathing
        bathing_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && hat.bathing
        bathing_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && hat.bathing
        bathing_hat4f_12_14 << hat
      #14~17時の入浴ヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && hat.bathing
        bathing_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && hat.bathing
        bathing_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && hat.bathing
        bathing_hat4f_14_17 << hat
      #17~19時の入浴ヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && hat.bathing
        bathing_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && hat.bathing
        bathing_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && hat.bathing
        bathing_hat4f_17_19 << hat
      #19~22時の入浴ヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && hat.bathing
        bathing_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && hat.bathing
        bathing_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && hat.bathing
        bathing_hat4f_19_22 << hat
      #22~3時の入浴ヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && hat.bathing
        bathing_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && hat.bathing
        bathing_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && hat.bathing
        bathing_hat4f_22_3 << hat
      #3~7時の入浴ヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && hat.bathing
        bathing_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && hat.bathing
        bathing_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && hat.bathing
        bathing_hat4f_3_7 << hat
      end

      #7~9時のその他ヒヤリ
      if time_range_7_9(hat) && hat.floor2 && hat.other_scene
        other_scene_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && hat.other_scene
        other_scene_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && hat.other_scene
        other_scene_hat4f_7_9 << hat
      #9~12時のその他ヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && hat.other_scene
        other_scene_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && hat.other_scene
        other_scene_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && hat.other_scene
        other_scene_hat4f_9_12 << hat
      #12~14時のその他ヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && hat.other_scene
        other_scene_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && hat.other_scene
        other_scene_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && hat.other_scene
        other_scene_hat4f_12_14 << hat
      #14~17時のその他ヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && hat.other_scene
        other_scene_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && hat.other_scene
        other_scene_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && hat.other_scene
        other_scene_hat4f_14_17 << hat
      #17~19時のその他ヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && hat.other_scene
        other_scene_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && hat.other_scene
        other_scene_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && hat.other_scene
        other_scene_hat4f_17_19 << hat
      #19~22時のその他ヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && hat.other_scene
        other_scene_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && hat.other_scene
        other_scene_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && hat.other_scene
        other_scene_hat4f_19_22 << hat
      #22~3時のその他ヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && hat.other_scene
        other_scene_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && hat.other_scene
        other_scene_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && hat.other_scene
        other_scene_hat4f_22_3 << hat
      #3~7時のその他ヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && hat.other_scene
        other_scene_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && hat.other_scene
        other_scene_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && hat.other_scene
        other_scene_hat4f_3_7 << hat
      end

      #7~9時の場面総合計ヒヤリ
      if time_range_7_9(hat) && hat.floor2 && all_scene(hat)
        total_scene_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && all_scene(hat)
        total_scene_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && all_scene(hat)
        total_scene_hat4f_7_9 << hat
      #9~12時の場面総合計ヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && all_scene(hat)
        total_scene_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && all_scene(hat)
        total_scene_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && all_scene(hat)
        total_scene_hat4f_9_12 << hat
      #12~14時の場面総合計ヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && all_scene(hat)
        total_scene_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && all_scene(hat)
        total_scene_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && all_scene(hat)
        total_scene_hat4f_12_14 << hat
      #14~17時の場面総合計ヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && all_scene(hat)
        total_scene_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && all_scene(hat)
        total_scene_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && all_scene(hat)
        total_scene_hat4f_14_17 << hat
      #17~19時の場面総合計ヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && all_scene(hat)
        total_scene_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && all_scene(hat)
        total_scene_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && all_scene(hat)
        total_scene_hat4f_17_19 << hat
      #19~22時の場面総合計ヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && all_scene(hat)
        total_scene_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && all_scene(hat)
        total_scene_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && all_scene(hat)
        total_scene_hat4f_19_22 << hat
      #22~3時の場面総合計ヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && all_scene(hat)
        total_scene_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && all_scene(hat)
        total_scene_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && all_scene(hat)
        total_scene_hat4f_22_3 << hat
      #3~7時の場面総合計ヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && all_scene(hat)
        total_scene_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && all_scene(hat)
        total_scene_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && all_scene(hat)
        total_scene_hat4f_3_7 << hat
      end
    end

    [
    #返り値：7~9時の転倒・転落ヒヤリ
    fall_hat2f_7_9, fall_hat3f_7_9, fall_hat4f_7_9,
    #返り値：9~12時の転倒・転落ヒヤリ
    fall_hat2f_9_12, fall_hat3f_9_12, fall_hat4f_9_12,
    #返り値：12~14時の転倒・転落ヒヤリ
    fall_hat2f_12_14, fall_hat3f_12_14, fall_hat4f_12_14,
    #返り値：14~17時の転倒・転落ヒヤリ
    fall_hat2f_14_17, fall_hat3f_14_17, fall_hat4f_14_17,
    #返り値：17~19時の転倒・転落ヒヤリ
    fall_hat2f_17_19, fall_hat3f_17_19, fall_hat4f_17_19,
    #返り値：19~22時の転倒・転落ヒヤリ
    fall_hat2f_19_22, fall_hat3f_19_22, fall_hat4f_19_22,
    #返り値：22~3時の転倒・転落ヒヤリ
    fall_hat2f_22_3, fall_hat3f_22_3, fall_hat4f_22_3,
    #返り値：3~7時の転倒・転落ヒヤリ
    fall_hat2f_3_7, fall_hat3f_3_7, fall_hat4f_3_7,

    #返り値：7~9時の行方不明・所在不明ヒヤリ
    missing_hat2f_7_9, missing_hat3f_7_9, missing_hat4f_7_9,
    #返り値：9~12時の行方不明・所在不明ヒヤリ
    missing_hat2f_9_12, missing_hat3f_9_12, missing_hat4f_9_12,
    #返り値：12~14時の行方不明・所在不明ヒヤリ
    missing_hat2f_12_14, missing_hat3f_12_14, missing_hat4f_12_14,
    #返り値：14~17時の行方不明・所在不明ヒヤリ
    missing_hat2f_14_17, missing_hat3f_14_17, missing_hat4f_14_17,
    #返り値：17~19時の行方不明・所在不明ヒヤリ
    missing_hat2f_17_19, missing_hat3f_17_19, missing_hat4f_17_19,
    #返り値：19~22時の行方不明・所在不明ヒヤリ
    missing_hat2f_19_22, missing_hat3f_19_22, missing_hat4f_19_22,
    #返り値：22~3時の行方不明・所在不明ヒヤリ
    missing_hat2f_22_3, missing_hat3f_22_3, missing_hat4f_22_3,
    #返り値：3~7時の行方不明・所在不明ヒヤリ
    missing_hat2f_3_7, missing_hat3f_3_7, missing_hat4f_3_7,

    #返り値：7~9時の飲食に関することヒヤリ
    meal_hat2f_7_9, meal_hat3f_7_9, meal_hat4f_7_9,
    #返り値：9~12時の飲食に関することヒヤリ
    meal_hat2f_9_12, meal_hat3f_9_12, meal_hat4f_9_12,
    #返り値：12~14時の飲食に関することヒヤリ
    meal_hat2f_12_14, meal_hat3f_12_14, meal_hat4f_12_14,
    #返り値：14~17時の飲食に関することヒヤリ
    meal_hat2f_14_17, meal_hat3f_14_17, meal_hat4f_14_17,
    #返り値：17~19時の飲食に関することヒヤリ
    meal_hat2f_17_19, meal_hat3f_17_19, meal_hat4f_17_19,
    #返り値：19~22時の飲食に関することヒヤリ
    meal_hat2f_19_22, meal_hat3f_19_22, meal_hat4f_19_22,
    #返り値：22~3時の飲食に関することヒヤリ
    meal_hat2f_22_3, meal_hat3f_22_3, meal_hat4f_22_3,
    #返り値：3~7時の飲食に関することヒヤリ
    meal_hat2f_3_7, meal_hat3f_3_7, meal_hat4f_3_7,

    #返り値：7~9時の薬関係ヒヤリ
    medicine_hat2f_7_9, medicine_hat3f_7_9, medicine_hat4f_7_9,
    #返り値：9~12時の薬関係ヒヤリ
    medicine_hat2f_9_12, medicine_hat3f_9_12, medicine_hat4f_9_12,
    #返り値：12~14時の薬関係ヒヤリ
    medicine_hat2f_12_14, medicine_hat3f_12_14, medicine_hat4f_12_14,
    #返り値：14~17時の薬関係ヒヤリ
    medicine_hat2f_14_17, medicine_hat3f_14_17, medicine_hat4f_14_17,
    #返り値：17~19時の薬関係ヒヤリ
    medicine_hat2f_17_19, medicine_hat3f_17_19, medicine_hat4f_17_19,
    #返り値：19~22時の薬関係ヒヤリ
    medicine_hat2f_19_22, medicine_hat3f_19_22, medicine_hat4f_19_22,
    #返り値：22~3時の薬関係ヒヤリ
    medicine_hat2f_22_3, medicine_hat3f_22_3, medicine_hat4f_22_3,
    #返り値：3~7時の薬関係ヒヤリ
    medicine_hat2f_3_7, medicine_hat3f_3_7, medicine_hat4f_3_7,

    #返り値：7~9時の他害・自傷行為ヒヤリ
    scratch_hat2f_7_9, scratch_hat3f_7_9, scratch_hat4f_7_9,
    #返り値：9~12時の他害・自傷行為ヒヤリ
    scratch_hat2f_9_12, scratch_hat3f_9_12, scratch_hat4f_9_12,
    #返り値：12~14時の他害・自傷行為ヒヤリ
    scratch_hat2f_12_14, scratch_hat3f_12_14, scratch_hat4f_12_14,
    #返り値：14~17時の他害・自傷行為ヒヤリ
    scratch_hat2f_14_17, scratch_hat3f_14_17, scratch_hat4f_14_17,
    #返り値：17~19時の他害・自傷行為ヒヤリ
    scratch_hat2f_17_19, scratch_hat3f_17_19, scratch_hat4f_17_19,
    #返り値：19~22時の他害・自傷行為ヒヤリ
    scratch_hat2f_19_22, scratch_hat3f_19_22, scratch_hat4f_19_22,
    #返り値：22~3時の他害・自傷行為ヒヤリ
    scratch_hat2f_22_3, scratch_hat3f_22_3, scratch_hat4f_22_3,
    #返り値：3~7時の他害・自傷行為ヒヤリ
    scratch_hat2f_3_7, scratch_hat3f_3_7, scratch_hat4f_3_7,

    #返り値：7~9時の環境ヒヤリ
    environment_hat2f_7_9, environment_hat3f_7_9, environment_hat4f_7_9,
    #返り値：9~12時の環境ヒヤリ
    environment_hat2f_9_12, environment_hat3f_9_12, environment_hat4f_9_12,
    #返り値：12~14時の環境ヒヤリ
    environment_hat2f_12_14, environment_hat3f_12_14, environment_hat4f_12_14,
    #返り値：14~17時の環境ヒヤリ
    environment_hat2f_14_17, environment_hat3f_14_17, environment_hat4f_14_17,
    #返り値：17~19時の環境ヒヤリ
    environment_hat2f_17_19, environment_hat3f_17_19, environment_hat4f_17_19,
    #返り値：19~22時の環境ヒヤリ
    environment_hat2f_19_22, environment_hat3f_19_22, environment_hat4f_19_22,
    #返り値：22~3時の環境ヒヤリ
    environment_hat2f_22_3, environment_hat3f_22_3, environment_hat4f_22_3,
    #返り値：3~7時の環境ヒヤリ
    environment_hat2f_3_7, environment_hat3f_3_7, environment_hat4f_3_7,

    #返り値：7~9時の情報・連絡・報告ヒヤリ
    info_contact_hat2f_7_9, info_contact_hat3f_7_9, info_contact_hat4f_7_9,
    #返り値：9~12時の情報・連絡・報告ヒヤリ
    info_contact_hat2f_9_12, info_contact_hat3f_9_12, info_contact_hat4f_9_12,
    #返り値：12~14時の情報・連絡・報告ヒヤリ
    info_contact_hat2f_12_14, info_contact_hat3f_12_14, info_contact_hat4f_12_14,
    #返り値：14~17時の情報・連絡・報告ヒヤリ
    info_contact_hat2f_14_17, info_contact_hat3f_14_17, info_contact_hat4f_14_17,
    #返り値：17~19時の情報・連絡・報告ヒヤリ
    info_contact_hat2f_17_19, info_contact_hat3f_17_19, info_contact_hat4f_17_19,
    #返り値：19~22時の情報・連絡・報告ヒヤリ
    info_contact_hat2f_19_22, info_contact_hat3f_19_22, info_contact_hat4f_19_22,
    #返り値：22~3時の情報・連絡・報告ヒヤリ
    info_contact_hat2f_22_3, info_contact_hat3f_22_3, info_contact_hat4f_22_3,
    #返り値：3~7時の情報・連絡・報告ヒヤリ
    info_contact_hat2f_3_7, info_contact_hat3f_3_7, info_contact_hat4f_3_7,

    #返り値：7~9時の個人情報・人権ヒヤリ
    personal_info_hat2f_7_9, personal_info_hat3f_7_9, personal_info_hat4f_7_9,
    #返り値：9~12時の個人情報・人権ヒヤリ
    personal_info_hat2f_9_12, personal_info_hat3f_9_12, personal_info_hat4f_9_12,
    #返り値：12~14時の個人情報・人権ヒヤリ
    personal_info_hat2f_12_14, personal_info_hat3f_12_14, personal_info_hat4f_12_14,
    #返り値：14~17時の個人情報・人権ヒヤリ
    personal_info_hat2f_14_17, personal_info_hat3f_14_17, personal_info_hat4f_14_17,
    #返り値：17~19時の個人情報・人権ヒヤリ
    personal_info_hat2f_17_19, personal_info_hat3f_17_19, personal_info_hat4f_17_19,
    #返り値：19~22時の個人情報・人権ヒヤリ
    personal_info_hat2f_19_22, personal_info_hat3f_19_22, personal_info_hat4f_19_22,
    #返り値：22~3時の個人情報・人権ヒヤリ
    personal_info_hat2f_22_3, personal_info_hat3f_22_3, personal_info_hat4f_22_3,
    #返り値：3~7時の個人情報・人権ヒヤリ
    personal_info_hat2f_3_7, personal_info_hat3f_3_7, personal_info_hat4f_3_7,

    #返り値：7~9時の紛失ヒヤリ
    lost_hat2f_7_9, lost_hat3f_7_9, lost_hat4f_7_9,
    #返り値：9~12時の紛失ヒヤリ
    lost_hat2f_9_12, lost_hat3f_9_12, lost_hat4f_9_12,
    #返り値：12~14時の紛失ヒヤリ
    lost_hat2f_12_14, lost_hat3f_12_14, lost_hat4f_12_14,
    #返り値：14~17時の紛失ヒヤリ
    lost_hat2f_14_17, lost_hat3f_14_17, lost_hat4f_14_17,
    #返り値：17~19時の紛失ヒヤリ
    lost_hat2f_17_19, lost_hat3f_17_19, lost_hat4f_17_19,
    #返り値：19~22時の紛失ヒヤリ
    lost_hat2f_19_22, lost_hat3f_19_22, lost_hat4f_19_22,
    #返り値：22~3時の紛失ヒヤリ
    lost_hat2f_22_3, lost_hat3f_22_3, lost_hat4f_22_3,
    #返り値：3~7時の紛失ヒヤリ
    lost_hat2f_3_7, lost_hat3f_3_7, lost_hat4f_3_7,

    #返り値：7~9時の器物破損ヒヤリ
    damage_hat2f_7_9, damage_hat3f_7_9, damage_hat4f_7_9,
    #返り値：9~12時の器物破損ヒヤリ
    damage_hat2f_9_12, damage_hat3f_9_12, damage_hat4f_9_12,
    #返り値：12~14時の器物破損ヒヤリ
    damage_hat2f_12_14, damage_hat3f_12_14, damage_hat4f_12_14,
    #返り値：14~17時の器物破損ヒヤリ
    damage_hat2f_14_17, damage_hat3f_14_17, damage_hat4f_14_17,
    #返り値：17~19時の器物破損ヒヤリ
    damage_hat2f_17_19, damage_hat3f_17_19, damage_hat4f_17_19,
    #返り値：19~22時の器物破損ヒヤリ
    damage_hat2f_19_22, damage_hat3f_19_22, damage_hat4f_19_22,
    #返り値：22~3時の器物破損ヒヤリ
    damage_hat2f_22_3, damage_hat3f_22_3, damage_hat4f_22_3,
    #返り値：3~7時の器物破損ヒヤリ
    damage_hat2f_3_7, damage_hat3f_3_7, damage_hat4f_3_7,

    #返り値：7~9時の金銭ヒヤリ
    money_hat2f_7_9, money_hat3f_7_9, money_hat4f_7_9,
    #返り値：9~12時の金銭ヒヤリ
    money_hat2f_9_12, money_hat3f_9_12, money_hat4f_9_12,
    #返り値：12~14時の金銭ヒヤリ
    money_hat2f_12_14, money_hat3f_12_14, money_hat4f_12_14,
    #返り値：14~17時の金銭ヒヤリ
    money_hat2f_14_17, money_hat3f_14_17, money_hat4f_14_17,
    #返り値：17~19時の金銭ヒヤリ
    money_hat2f_17_19, money_hat3f_17_19, money_hat4f_17_19,
    #返り値：19~22時の金銭ヒヤリ
    money_hat2f_19_22, money_hat3f_19_22, money_hat4f_19_22,
    #返り値：22~3時の金銭ヒヤリ
    money_hat2f_22_3, money_hat3f_22_3, money_hat4f_22_3,
    #返り値：3~7時の金銭ヒヤリ
    money_hat2f_3_7, money_hat3f_3_7, money_hat4f_3_7,

    #返り値：7~9時の医療的ケアのヒヤリ
    medical_care_hat2f_7_9, medical_care_hat3f_7_9, medical_care_hat4f_7_9,
    #返り値：9~12時の医療的ケアのヒヤリ
    medical_care_hat2f_9_12, medical_care_hat3f_9_12, medical_care_hat4f_9_12,
    #返り値：12~14時の医療的ケアのヒヤリ
    medical_care_hat2f_12_14, medical_care_hat3f_12_14, medical_care_hat4f_12_14,
    #返り値：14~17時の医療的ケアのヒヤリ
    medical_care_hat2f_14_17, medical_care_hat3f_14_17, medical_care_hat4f_14_17,
    #返り値：17~19時の医療的ケアのヒヤリ
    medical_care_hat2f_17_19, medical_care_hat3f_17_19, medical_care_hat4f_17_19,
    #返り値：19~22時の医療的ケアのヒヤリ
    medical_care_hat2f_19_22, medical_care_hat3f_19_22, medical_care_hat4f_19_22,
    #返り値：22~3時の医療的ケアのヒヤリ
    medical_care_hat2f_22_3, medical_care_hat3f_22_3, medical_care_hat4f_22_3,
    #返り値：3~7時の医療的ケアのヒヤリ
    medical_care_hat2f_3_7, medical_care_hat3f_3_7, medical_care_hat4f_3_7,

    #返り値：7~9時の感染症ヒヤリ
    infection_hat2f_7_9, infection_hat3f_7_9, infection_hat4f_7_9,
    #返り値：9~12時の感染症ヒヤリ
    infection_hat2f_9_12, infection_hat3f_9_12, infection_hat4f_9_12,
    #返り値：12~14時の感染症ヒヤリ
    infection_hat2f_12_14, infection_hat3f_12_14, infection_hat4f_12_14,
    #返り値：14~17時の感染症ヒヤリ
    infection_hat2f_14_17, infection_hat3f_14_17, infection_hat4f_14_17,
    #返り値：17~19時の感染症ヒヤリ
    infection_hat2f_17_19, infection_hat3f_17_19, infection_hat4f_17_19,
    #返り値：19~22時の紛失ヒヤリ
    infection_hat2f_19_22, infection_hat3f_19_22, infection_hat4f_19_22,
    #返り値：22~3時の感染症ヒヤリ
    infection_hat2f_22_3, infection_hat3f_22_3, infection_hat4f_22_3,
    #返り値：3~7時の感染症ヒヤリ
    infection_hat2f_3_7, infection_hat3f_3_7, infection_hat4f_3_7,

    #返り値：7~9時の忘れ物・返却忘れヒヤリ
    forget_hat2f_7_9, forget_hat3f_7_9, forget_hat4f_7_9,
    #返り値：9~12時の忘れ物・返却忘れヒヤリ
    forget_hat2f_9_12, forget_hat3f_9_12, forget_hat4f_9_12,
    #返り値：12~14時の忘れ物・返却忘れヒヤリ
    forget_hat2f_12_14, forget_hat3f_12_14, forget_hat4f_12_14,
    #返り値：14~17時の忘れ物・返却忘れヒヤリ
    forget_hat2f_14_17, forget_hat3f_14_17, forget_hat4f_14_17,
    #返り値：17~19時の忘れ物・返却忘れヒヤリ
    forget_hat2f_17_19, forget_hat3f_17_19, forget_hat4f_17_19,
    #返り値：19~22時の忘れ物・返却忘れヒヤリ
    forget_hat2f_19_22, forget_hat3f_19_22, forget_hat4f_19_22,
    #返り値：22~3時の忘れ物・返却忘れヒヤリ
    forget_hat2f_22_3, forget_hat3f_22_3, forget_hat4f_22_3,
    #返り値：3~7時の忘れ物・返却忘れヒヤリ
    forget_hat2f_3_7, forget_hat3f_3_7, forget_hat4f_3_7,

    #返り値：7~9時のその他ヒヤリ
    other_hat2f_7_9, other_hat3f_7_9, other_hat4f_7_9,
    #返り値：9~12時のその他ヒヤリ
    other_hat2f_9_12, other_hat3f_9_12, other_hat4f_9_12,
    #返り値：12~14時のその他ヒヤリ
    other_hat2f_12_14, other_hat3f_12_14, other_hat4f_12_14,
    #返り値：14~17時のその他ヒヤリ
    other_hat2f_14_17, other_hat3f_14_17, other_hat4f_14_17,
    #返り値：17~19時のその他ヒヤリ
    other_hat2f_17_19, other_hat3f_17_19, other_hat4f_17_19,
    #返り値：19~22時のその他ヒヤリ
    other_hat2f_19_22, other_hat3f_19_22, other_hat4f_19_22,
    #返り値：22~3時のその他ヒヤリ
    other_hat2f_22_3, other_hat3f_22_3, other_hat4f_22_3,
    #返り値：3~7時のその他ヒヤリ
    other_hat2f_3_7, other_hat3f_3_7, other_hat4f_3_7,

    #返り値：7~9時の総合計ヒヤリ
    total_hat2f_7_9, total_hat3f_7_9, total_hat4f_7_9,
    #返り値：9~12時の総合計ヒヤリ
    total_hat2f_9_12, total_hat3f_9_12, total_hat4f_9_12,
    #返り値：12~14時の総合計ヒヤリ
    total_hat2f_12_14, total_hat3f_12_14, total_hat4f_12_14,
    #返り値：14~17時の総合計ヒヤリ
    total_hat2f_14_17, total_hat3f_14_17, total_hat4f_14_17,
    #返り値：17~19時の総合計ヒヤリ
    total_hat2f_17_19, total_hat3f_17_19, total_hat4f_17_19,
    #返り値：19~22時の総合計ヒヤリ
    total_hat2f_19_22, total_hat3f_19_22, total_hat4f_19_22,
    #返り値：22~3時の総合計ヒヤリ
    total_hat2f_22_3, total_hat3f_22_3, total_hat4f_22_3,
    #返り値：3~7時の総合計ヒヤリ
    total_hat2f_3_7, total_hat3f_3_7, total_hat4f_3_7,

    #返り値：7~9時の通所・送迎ヒヤリ
    service_hat2f_7_9, service_hat3f_7_9, service_hat4f_7_9,
    #返り値：9~12時の通所・送迎ヒヤリ
    service_hat2f_9_12, service_hat3f_9_12, service_hat4f_9_12,
    #返り値：12~14時の通所・送迎ヒヤリ
    service_hat2f_12_14, service_hat3f_12_14, service_hat4f_12_14,
    #返り値：14~17時の通所・送迎ヒヤリ
    service_hat2f_14_17, service_hat3f_14_17, service_hat4f_14_17,
    #返り値：17~19時の通所・送迎ヒヤリ
    service_hat2f_17_19, service_hat3f_17_19, service_hat4f_17_19,
    #返り値：19~22時の通所・送迎ヒヤリ
    service_hat2f_19_22, service_hat3f_19_22, service_hat4f_19_22,
    #返り値：22~3時の通所・送迎ヒヤリ
    service_hat2f_22_3, service_hat3f_22_3, service_hat4f_22_3,
    #返り値：3~7時の通所・送迎ヒヤリ
    service_hat2f_3_7, service_hat3f_3_7, service_hat4f_3_7,

    #返り値：7~9時の活動・支援ヒヤリ
    support_hat2f_7_9, support_hat3f_7_9, support_hat4f_7_9,
    #返り値：9~12時の活動・支援ヒヤリ
    support_hat2f_9_12, support_hat3f_9_12, support_hat4f_9_12,
    #返り値：12~14時の活動・支援ヒヤリ
    support_hat2f_12_14, support_hat3f_12_14, support_hat4f_12_14,
    #返り値：14~17時の活動・支援ヒヤリ
    support_hat2f_14_17, support_hat3f_14_17, support_hat4f_14_17,
    #返り値：17~19時の活動・支援ヒヤリ
    support_hat2f_17_19, support_hat3f_17_19, support_hat4f_17_19,
    #返り値：19~22時の活動・支援ヒヤリ
    support_hat2f_19_22, support_hat3f_19_22, support_hat4f_19_22,
    #返り値：22~3時の活動・支援ヒヤリ
    support_hat2f_22_3, support_hat3f_22_3, support_hat4f_22_3,
    #返り値：3~7時の活動・支援ヒヤリ
    support_hat2f_3_7, support_hat3f_3_7, support_hat4f_3_7,

    #返り値：7~9時の給食・配膳ヒヤリ
    lunch_hat2f_7_9, lunch_hat3f_7_9, lunch_hat4f_7_9,
    #返り値：9~12時の給食・配膳ヒヤリ
    lunch_hat2f_9_12, lunch_hat3f_9_12, lunch_hat4f_9_12,
    #返り値：12~14時の給食・配膳ヒヤリ
    lunch_hat2f_12_14, lunch_hat3f_12_14, lunch_hat4f_12_14,
    #返り値：14~17時の給食・配膳ヒヤリ
    lunch_hat2f_14_17, lunch_hat3f_14_17, lunch_hat4f_14_17,
    #返り値：17~19時の給食・配膳ヒヤリ
    lunch_hat2f_17_19, lunch_hat3f_17_19, lunch_hat4f_17_19,
    #返り値：19~22時の給食・配膳ヒヤリ
    lunch_hat2f_19_22, lunch_hat3f_19_22, lunch_hat4f_19_22,
    #返り値：22~3時の給食・配膳ヒヤリ
    lunch_hat2f_22_3, lunch_hat3f_22_3, lunch_hat4f_22_3,
    #返り値：3~7時の給食・配膳ヒヤリ
    lunch_hat2f_3_7, lunch_hat3f_3_7, lunch_hat4f_3_7,

    #返り値：7~9時のトイレ・排泄ヒヤリ
    toilet_hat2f_7_9, toilet_hat3f_7_9, toilet_hat4f_7_9,
    #返り値：9~12時のトイレ・排泄ヒヤリ
    toilet_hat2f_9_12, toilet_hat3f_9_12, toilet_hat4f_9_12,
    #返り値：12~14時のトイレ・排泄ヒヤリ
    toilet_hat2f_12_14, toilet_hat3f_12_14, toilet_hat4f_12_14,
    #返り値：14~17時のトイレ・排泄ヒヤリ
    toilet_hat2f_14_17, toilet_hat3f_14_17, toilet_hat4f_14_17,
    #返り値：17~19時のトイレ・排泄ヒヤリ
    toilet_hat2f_17_19, toilet_hat3f_17_19, toilet_hat4f_17_19,
    #返り値：19~22時のトイレ・排泄ヒヤリ
    toilet_hat2f_19_22, toilet_hat3f_19_22, toilet_hat4f_19_22,
    #返り値：22~3時のトイレ・排泄ヒヤリ
    toilet_hat2f_22_3, toilet_hat3f_22_3, toilet_hat4f_22_3,
    #返り値：3~7時のトイレ・排泄ヒヤリ
    toilet_hat2f_3_7, toilet_hat3f_3_7, toilet_hat4f_3_7,

    #返り値：7~9時の入浴ヒヤリ
    bathing_hat2f_7_9, bathing_hat3f_7_9, bathing_hat4f_7_9,
    #返り値：9~12時の入浴ヒヤリ
    bathing_hat2f_9_12, bathing_hat3f_9_12, bathing_hat4f_9_12,
    #返り値：12~14時の入浴ヒヤリ
    bathing_hat2f_12_14, bathing_hat3f_12_14, bathing_hat4f_12_14,
    #返り値：14~17時の入浴ヒヤリ
    bathing_hat2f_14_17, bathing_hat3f_14_17, bathing_hat4f_14_17,
    #返り値：17~19時の入浴ヒヤリ
    bathing_hat2f_17_19, bathing_hat3f_17_19, bathing_hat4f_17_19,
    #返り値：19~22時の入浴ヒヤリ
    bathing_hat2f_19_22, bathing_hat3f_19_22, bathing_hat4f_19_22,
    #返り値：22~3時の入浴ヒヤリ
    bathing_hat2f_22_3, bathing_hat3f_22_3, bathing_hat4f_22_3,
    #返り値：3~7時の入浴ヒヤリ
    bathing_hat2f_3_7, bathing_hat3f_3_7, bathing_hat4f_3_7,

    #返り値：7~9時のその他ヒヤリ
    other_scene_hat2f_7_9, other_scene_hat3f_7_9, other_scene_hat4f_7_9,
    #返り値：9~12時のその他ヒヤリ
    other_scene_hat2f_9_12, other_scene_hat3f_9_12, other_scene_hat4f_9_12,
    #返り値：12~14時のその他ヒヤリ
    other_scene_hat2f_12_14, other_scene_hat3f_12_14, other_scene_hat4f_12_14,
    #返り値：14~17時のその他ヒヤリ
    other_scene_hat2f_14_17, other_scene_hat3f_14_17, other_scene_hat4f_14_17,
    #返り値：17~19時のその他ヒヤリ
    other_scene_hat2f_17_19, other_scene_hat3f_17_19, other_scene_hat4f_17_19,
    #返り値：19~22時のその他ヒヤリ
    other_scene_hat2f_19_22, other_scene_hat3f_19_22, other_scene_hat4f_19_22,
    #返り値：22~3時のその他ヒヤリ
    other_scene_hat2f_22_3, other_scene_hat3f_22_3, other_scene_hat4f_22_3,
    #返り値：3~7時のその他ヒヤリ
    other_scene_hat2f_3_7, other_scene_hat3f_3_7, other_scene_hat4f_3_7,

    #返り値：7~9時の場面総合計ヒヤリ
    total_scene_hat2f_7_9, total_scene_hat3f_7_9, total_scene_hat4f_7_9,
    #返り値：9~12時の場面総合計ヒヤリ
    total_scene_hat2f_9_12, total_scene_hat3f_9_12, total_scene_hat4f_9_12,
    #返り値：12~14時の場面総合計ヒヤリ
    total_scene_hat2f_12_14, total_scene_hat3f_12_14, total_scene_hat4f_12_14,
    #返り値：14~17時の場面総合計ヒヤリ
    total_scene_hat2f_14_17, total_scene_hat3f_14_17, total_scene_hat4f_14_17,
    #返り値：17~19時の場面総合計ヒヤリ
    total_scene_hat2f_17_19, total_scene_hat3f_17_19, total_scene_hat4f_17_19,
    #返り値：19~22時の場面総合計ヒヤリ
    total_scene_hat2f_19_22, total_scene_hat3f_19_22, total_scene_hat4f_19_22,
    #返り値：22~3時の場面総合計ヒヤリ
    total_scene_hat2f_22_3, total_scene_hat3f_22_3, total_scene_hat4f_22_3,
    #返り値：3~7時の場面総合計ヒヤリ
    total_scene_hat2f_3_7, total_scene_hat3f_3_7, total_scene_hat4f_3_7
    ]
  end

end