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
end
