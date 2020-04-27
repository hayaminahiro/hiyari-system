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



end