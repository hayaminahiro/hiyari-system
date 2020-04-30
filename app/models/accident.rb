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
  #フロア
  scope :floor, -> (num) { where(accident_floor: num) }
  #ヒヤリor事故
  scope :hat, -> { where(which_accident: "ヒヤリハット") }
  scope :accident, -> { where(which_accident: "事故") }
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

    accidents.each do |hat|
      #7~9時の転倒・転落ヒヤリ
      if time_range_7_9(hat) && hat.floor2 && hat.hat && hat.fall
        fall_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && hat.hat && hat.fall
        fall_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && hat.hat && hat.fall
        fall_hat4f_7_9 << hat
      #9~12時の転倒・転落ヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && hat.hat && hat.fall
        fall_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && hat.hat && hat.fall
        fall_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && hat.hat && hat.fall
        fall_hat4f_9_12 << hat
      #12~14時の転倒・転落ヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && hat.hat && hat.fall
        fall_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && hat.hat && hat.fall
        fall_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && hat.hat && hat.fall
        fall_hat4f_12_14 << hat
      #14~17時の転倒・転落ヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && hat.hat && hat.fall
        fall_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && hat.hat && hat.fall
        fall_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && hat.hat && hat.fall
        fall_hat4f_14_17 << hat
      #17~19時の転倒・転落ヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && hat.hat && hat.fall
        fall_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && hat.hat && hat.fall
        fall_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && hat.hat && hat.fall
        fall_hat4f_17_19 << hat
      #19~22時の転倒・転落ヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && hat.hat && hat.fall
        fall_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && hat.hat && hat.fall
        fall_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && hat.hat && hat.fall
        fall_hat4f_19_22 << hat
      #22~3時の転倒・転落ヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && hat.hat && hat.fall
        fall_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && hat.hat && hat.fall
        fall_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && hat.hat && hat.fall
        fall_hat4f_22_3 << hat
      #3~7時の転倒・転落ヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && hat.hat && hat.fall
        fall_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && hat.hat && hat.fall
        fall_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && hat.hat && hat.fall
        fall_hat4f_3_7 << hat
      end

      #7~9時の行方不明・所在不明ヒヤリ
      if time_range_7_9(hat) && hat.floor2 && hat.hat && hat.missing
        missing_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && hat.hat && hat.missing
        missing_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && hat.hat && hat.missing
        missing_hat4f_7_9 << hat
        #9~12時の行方不明・所在不明ヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && hat.hat && hat.missing
        missing_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && hat.hat && hat.missing
        missing_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && hat.hat && hat.missing
        missing_hat4f_9_12 << hat
        #12~14時の行方不明・所在不明ヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && hat.hat && hat.missing
        missing_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && hat.hat && hat.missing
        missing_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && hat.hat && hat.missing
        missing_hat4f_12_14 << hat
        #14~17時の行方不明・所在不明ヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && hat.hat && hat.missing
        missing_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && hat.hat && hat.missing
        missing_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && hat.hat && hat.missing
        missing_hat4f_14_17 << hat
        #17~19時の行方不明・所在不明ヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && hat.hat && hat.missing
        missing_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && hat.hat && hat.missing
        missing_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && hat.hat && hat.missing
        missing_hat4f_17_19 << hat
        #19~22時の行方不明・所在不明ヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && hat.hat && hat.missing
        missing_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && hat.hat && hat.missing
        missing_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && hat.hat && hat.missing
        missing_hat4f_19_22 << hat
        #22~3時の行方不明・所在不明ヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && hat.hat && hat.missing
        missing_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && hat.hat && hat.missing
        missing_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && hat.hat && hat.missing
        missing_hat4f_22_3 << hat
        #3~7時の行方不明・所在不明ヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && hat.hat && hat.missing
        missing_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && hat.hat && hat.missing
        missing_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && hat.hat && hat.missing
        missing_hat4f_3_7 << hat
      end

      #7~9時の飲食に関することヒヤリ
      if time_range_7_9(hat) && hat.floor2 && hat.hat && hat.meal
        meal_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && hat.hat && hat.meal
        meal_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && hat.hat && hat.meal
        meal_hat4f_7_9 << hat
        #9~12時の飲食に関することヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && hat.hat && hat.meal
        meal_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && hat.hat && hat.meal
        meal_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && hat.hat && hat.meal
        meal_hat4f_9_12 << hat
        #12~14時の飲食に関することヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && hat.hat && hat.meal
        meal_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && hat.hat && hat.meal
        meal_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && hat.hat && hat.meal
        meal_hat4f_12_14 << hat
        #14~17時の飲食に関することヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && hat.hat && hat.meal
        meal_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && hat.hat && hat.meal
        meal_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && hat.hat && hat.meal
        meal_hat4f_14_17 << hat
        #17~19時の飲食に関することヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && hat.hat && hat.meal
        meal_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && hat.hat && hat.meal
        meal_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && hat.hat && hat.meal
        meal_hat4f_17_19 << hat
        #19~22時の飲食に関することヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && hat.hat && hat.meal
        meal_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && hat.hat && hat.meal
        meal_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && hat.hat && hat.meal
        meal_hat4f_19_22 << hat
        #22~3時の飲食に関することヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && hat.hat && hat.meal
        meal_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && hat.hat && hat.meal
        meal_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && hat.hat && hat.meal
        meal_hat4f_22_3 << hat
        #3~7時の飲食に関することヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && hat.hat && hat.meal
        meal_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && hat.hat && hat.meal
        meal_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && hat.hat && hat.meal
        meal_hat4f_3_7 << hat
      end

      #7~9時の薬関係ヒヤリ
      if time_range_7_9(hat) && hat.floor2 && hat.hat && hat.medicine
        medicine_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && hat.hat && hat.medicine
        medicine_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && hat.hat && hat.medicine
        medicine_hat4f_7_9 << hat
        #9~12時の薬関係ヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && hat.hat && hat.medicine
        medicine_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && hat.hat && hat.medicine
        medicine_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && hat.hat && hat.medicine
        medicine_hat4f_9_12 << hat
        #12~14時の薬関係ヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && hat.hat && hat.medicine
        medicine_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && hat.hat && hat.medicine
        medicine_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && hat.hat && hat.medicine
        medicine_hat4f_12_14 << hat
        #14~17時の薬関係ヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && hat.hat && hat.medicine
        medicine_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && hat.hat && hat.medicine
        medicine_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && hat.hat && hat.medicine
        medicine_hat4f_14_17 << hat
        #17~19時の薬関係ヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && hat.hat && hat.medicine
        medicine_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && hat.hat && hat.medicine
        medicine_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && hat.hat && hat.medicine
        medicine_hat4f_17_19 << hat
        #19~22時の薬関係ヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && hat.hat && hat.medicine
        medicine_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && hat.hat && hat.medicine
        medicine_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && hat.hat && hat.medicine
        medicine_hat4f_19_22 << hat
        #22~3時の薬関係ヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && hat.hat && hat.medicine
        medicine_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && hat.hat && hat.medicine
        medicine_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && hat.hat && hat.medicine
        medicine_hat4f_22_3 << hat
        #3~7時の薬関係ヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && hat.hat && hat.medicine
        medicine_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && hat.hat && hat.medicine
        medicine_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && hat.hat && hat.medicine
        medicine_hat4f_3_7 << hat
      end

      #7~9時の他害・自傷行為ヒヤリ
      if time_range_7_9(hat) && hat.floor2 && hat.hat && hat.scratch
        scratch_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && hat.hat && hat.scratch
        scratch_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && hat.hat && hat.scratch
        scratch_hat4f_7_9 << hat
        #9~12時の他害・自傷行為ヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && hat.hat && hat.scratch
        scratch_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && hat.hat && hat.scratch
        scratch_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && hat.hat && hat.scratch
        scratch_hat4f_9_12 << hat
        #12~14時の他害・自傷行為ヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && hat.hat && hat.scratch
        scratch_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && hat.hat && hat.scratch
        scratch_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && hat.hat && hat.scratch
        scratch_hat4f_12_14 << hat
        #14~17時の他害・自傷行為ヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && hat.hat && hat.scratch
        scratch_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && hat.hat && hat.scratch
        scratch_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && hat.hat && hat.scratch
        scratch_hat4f_14_17 << hat
        #17~19時の他害・自傷行為ヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && hat.hat && hat.scratch
        scratch_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && hat.hat && hat.scratch
        scratch_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && hat.hat && hat.scratch
        scratch_hat4f_17_19 << hat
        #19~22時の他害・自傷行為ヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && hat.hat && hat.scratch
        scratch_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && hat.hat && hat.scratch
        scratch_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && hat.hat && hat.scratch
        scratch_hat4f_19_22 << hat
        #22~3時の他害・自傷行為ヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && hat.hat && hat.scratch
        scratch_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && hat.hat && hat.scratch
        scratch_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && hat.hat && hat.scratch
        scratch_hat4f_22_3 << hat
        #3~7時の他害・自傷行為ヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && hat.hat && hat.scratch
        scratch_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && hat.hat && hat.scratch
        scratch_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && hat.hat && hat.scratch
        scratch_hat4f_3_7 << hat
      end

      #7~9時の環境ヒヤリ
      if time_range_7_9(hat) && hat.floor2 && hat.hat && hat.environment
        environment_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && hat.hat && hat.environment
        environment_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && hat.hat && hat.environment
        environment_hat4f_7_9 << hat
        #9~12時の環境ヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && hat.hat && hat.environment
        environment_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && hat.hat && hat.environment
        environment_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && hat.hat && hat.environment
        environment_hat4f_9_12 << hat
        #12~14時の環境ヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && hat.hat && hat.environment
        environment_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && hat.hat && hat.environment
        environment_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && hat.hat && hat.environment
        environment_hat4f_12_14 << hat
        #14~17時の環境ヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && hat.hat && hat.environment
        environment_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && hat.hat && hat.environment
        environment_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && hat.hat && hat.environment
        environment_hat4f_14_17 << hat
        #17~19時の環境ヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && hat.hat && hat.environment
        environment_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && hat.hat && hat.environment
        environment_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && hat.hat && hat.environment
        environment_hat4f_17_19 << hat
        #19~22時の環境ヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && hat.hat && hat.environment
        environment_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && hat.hat && hat.environment
        environment_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && hat.hat && hat.environment
        environment_hat4f_19_22 << hat
        #22~3時の環境ヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && hat.hat && hat.environment
        environment_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && hat.hat && hat.environment
        environment_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && hat.hat && hat.environment
        environment_hat4f_22_3 << hat
        #3~7時の環境ヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && hat.hat && hat.environment
        environment_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && hat.hat && hat.environment
        environment_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && hat.hat && hat.environment
        environment_hat4f_3_7 << hat
      end

      #7~9時の情報・連絡・報告ヒヤリ
      if time_range_7_9(hat) && hat.floor2 && hat.hat && hat.info_contact
        info_contact_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && hat.hat && hat.info_contact
        info_contact_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && hat.hat && hat.info_contact
        info_contact_hat4f_7_9 << hat
        #9~12時の情報・連絡・報告ヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && hat.hat && hat.info_contact
        info_contact_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && hat.hat && hat.info_contact
        info_contact_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && hat.hat && hat.info_contact
        info_contact_hat4f_9_12 << hat
        #12~14時の情報・連絡・報告ヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && hat.hat && hat.info_contact
        info_contact_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && hat.hat && hat.info_contact
        info_contact_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && hat.hat && hat.info_contact
        info_contact_hat4f_12_14 << hat
        #14~17時の情報・連絡・報告ヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && hat.hat && hat.info_contact
        info_contact_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && hat.hat && hat.info_contact
        info_contact_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && hat.hat && hat.info_contact
        info_contact_hat4f_14_17 << hat
        #17~19時の情報・連絡・報告ヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && hat.hat && hat.info_contact
        info_contact_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && hat.hat && hat.info_contact
        info_contact_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && hat.hat && hat.info_contact
        info_contact_hat4f_17_19 << hat
        #19~22時の情報・連絡・報告ヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && hat.hat && hat.info_contact
        info_contact_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && hat.hat && hat.info_contact
        info_contact_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && hat.hat && hat.info_contact
        info_contact_hat4f_19_22 << hat
        #22~3時の情報・連絡・報告ヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && hat.hat && hat.info_contact
        info_contact_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && hat.hat && hat.info_contact
        info_contact_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && hat.hat && hat.info_contact
        info_contact_hat4f_22_3 << hat
        #3~7時の情報・連絡・報告ヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && hat.hat && hat.info_contact
        info_contact_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && hat.hat && hat.info_contact
        info_contact_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && hat.hat && hat.info_contact
        info_contact_hat4f_3_7 << hat
      end

      #7~9時の個人情報・人権ヒヤリ
      if time_range_7_9(hat) && hat.floor2 && hat.hat && hat.personal_info
        personal_info_hat2f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor3 && hat.hat && hat.personal_info
        info_contact_hat3f_7_9 << hat
      elsif time_range_7_9(hat) && hat.floor4 && hat.hat && hat.personal_info
        personal_info_hat4f_7_9 << hat
        #9~12時の個人情報・人権ヒヤリ
      elsif time_range_9_12(hat) && hat.floor2 && hat.hat && hat.personal_info
        personal_info_hat2f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor3 && hat.hat && hat.personal_info
        personal_info_hat3f_9_12 << hat
      elsif time_range_9_12(hat) && hat.floor4 && hat.hat && hat.personal_info
        personal_info_hat4f_9_12 << hat
        #12~14時の個人情報・人権ヒヤリ
      elsif time_range_12_14(hat) && hat.floor2 && hat.hat && hat.personal_info
        personal_info_hat2f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor3 && hat.hat && hat.personal_info
        personal_info_hat3f_12_14 << hat
      elsif time_range_12_14(hat) && hat.floor4 && hat.hat && hat.personal_info
        personal_info_hat4f_12_14 << hat
        #14~17時の個人情報・人権ヒヤリ
      elsif time_range_14_17(hat) && hat.floor2 && hat.hat && hat.personal_info
        personal_info_hat2f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor3 && hat.hat && hat.personal_info
        personal_info_hat3f_14_17 << hat
      elsif time_range_14_17(hat) && hat.floor4 && hat.hat && hat.personal_info
        personal_info_hat4f_14_17 << hat
        #17~19時の個人情報・人権ヒヤリ
      elsif time_range_17_19(hat) && hat.floor2 && hat.hat && hat.personal_info
        personal_info_hat2f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor3 && hat.hat && hat.personal_info
        personal_info_hat3f_17_19 << hat
      elsif time_range_17_19(hat) && hat.floor4 && hat.hat && hat.personal_info
        personal_info_hat4f_17_19 << hat
        #19~22時の個人情報・人権ヒヤリ
      elsif time_range_19_22(hat) && hat.floor2 && hat.hat && hat.personal_info
        personal_info_hat2f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor3 && hat.hat && hat.personal_info
        personal_info_hat3f_19_22 << hat
      elsif time_range_19_22(hat) && hat.floor4 && hat.hat && hat.personal_info
        personal_info_hat4f_19_22 << hat
        #22~3時の個人情報・人権ヒヤリ
      elsif time_range_22_3(hat) && hat.floor2 && hat.hat && hat.personal_info
        personal_info_hat2f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor3 && hat.hat && hat.personal_info
        personal_info_hat3f_22_3 << hat
      elsif time_range_22_3(hat) && hat.floor4 && hat.hat && hat.personal_info
        personal_info_hat4f_22_3 << hat
        #3~7時の情報・連絡・報告ヒヤリ
      elsif time_range_3_7(hat) && hat.floor2 && hat.hat && hat.personal_info
        personal_info_hat2f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor3 && hat.hat && hat.personal_info
        personal_info_hat3f_3_7 << hat
      elsif time_range_3_7(hat) && hat.floor4 && hat.hat && hat.personal_info
        personal_info_hat4f_3_7 << hat
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
    ]
  end

end