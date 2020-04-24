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

  scope :date, -> (date) { where(accident_datetime: date) }
  scope :floor, -> (num) { where(accident_floor: num) }
  scope :which_accident, -> (num) { where(which_accident: num) }
  scope :hat, -> { where(which_accident: "ヒヤリハット") }
  scope :accident, -> { where(which_accident: "事故") }
  scope :event_fall, -> { where(event_classification: "転倒・転落") }

end