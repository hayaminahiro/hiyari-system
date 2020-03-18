class Worker < ApplicationRecord
  belongs_to :facility

  validates :worker_name, presence: true, length: { in: 1..20 }
  #ひらがな入力バリデーション
  VALID_WORKER_NAME_CALL_REGEX = /\A[ぁ-んー－]+\z/
  validates :worker_name_call, length: { in: 1..20 }, format: { with: VALID_WORKER_NAME_CALL_REGEX }
  validates :sign_name, presence: true, length: { in: 1..5 }

end
