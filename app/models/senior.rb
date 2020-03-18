class Senior < ApplicationRecord
  belongs_to :facility

  validates :senior_name, presence: true, length: { in: 1..20 }
  #ひらがな入力バリデーション
  VALID_WORKER_NAME_CALL_REGEX = /\A[ぁ-んー－]+\z/
  validates :senior_name_call, length: { in: 1..20 }, format: { with: VALID_WORKER_NAME_CALL_REGEX }, allow_blank: true
  validates :floor, presence: true
  #validates :charge_worker, presence: true, length: { maximum: 20 }
end
