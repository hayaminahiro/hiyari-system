class Worker < ApplicationRecord
  belongs_to :facility

  has_many :senior_workers, dependent: :destroy
  has_many :seniors, through: :senior_workers

  accepts_nested_attributes_for :senior_workers

  validates :worker_name, presence: true, length: { in: 1..25 }
  #ひらがな入力バリデーション
  VALID_WORKER_NAME_CALL_REGEX = /\A[ぁ-んー－]+\z/
  validates :worker_name_call, length: { in: 1..25 }, format: { with: VALID_WORKER_NAME_CALL_REGEX }, allow_blank: true
  validates :sign_name, presence: true, length: { in: 1..6 }

  #役職選択
  enum position: {
      なし: 0, ２階主任: 1, ３階主任: 2, ４階主任: 3, ２階係長: 4, ３階係長: 5, ４階係長: 6, リスクマネジャー: 7, 次長: 8, 施設長: 9
  }

  #勤務フロア
  scope :floor, -> (num) { where(working_floor: num) }
  #勤務中or退職
  scope :working, -> { where(working_flg: true) }
  scope :retirement, -> { where(working_flg: false) }
  #ふりがな：あいうえお順で表示
  scope :workers_sorted, -> { order(worker_name_call: :asc) }
  # N+1問題
  scope :including_facility, -> { includes(:facility) }

end

