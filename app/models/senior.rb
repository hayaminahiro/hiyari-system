class Senior < ApplicationRecord
  belongs_to :facility

  has_many :senior_workers, dependent: :destroy
  has_many :workers, through: :senior_workers
  has_many :accidents, dependent: :destroy

  accepts_nested_attributes_for :senior_workers

  validates :senior_name, presence: true, length: { in: 1..20 }
  #ひらがな入力バリデーション
  VALID_WORKER_NAME_CALL_REGEX = /\A[ぁ-んー－]+\z/
  validates :senior_name_call, length: { in: 1..20 }, format: { with: VALID_WORKER_NAME_CALL_REGEX }, allow_blank: true
  validates :floor, presence: true
  #validates :charge_worker, presence: true
  #validates :worker_ids, presence: true

  #利用者フロア
  scope :floor, -> (num) { where(floor: num) }
  #現在施設利用中or退所中
  scope :using, -> { where(using_flg: true) }
  scope :leaving, -> { where(using_flg: false) }
  #名前順で表示
  scope :name_sorted, -> { order(senior_name_call: :asc) }
  # N+1問題
  scope :including_facility, -> { includes(:facility) }

  #利用階
  def floor2
    2 if self.floor == 2
  end

  def floor3
    3 if self.floor == 3
  end

  def floor4
    4 if self.floor == 4
  end
end
