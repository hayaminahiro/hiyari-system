class Worker < ApplicationRecord
  belongs_to :facility

  validates :worker_name, presence: true, length: { in: 1..25 }
  #ひらがな入力バリデーション
  VALID_WORKER_NAME_CALL_REGEX = /\A[ぁ-んー－]+\z/
  validates :worker_name_call, length: { in: 1..25 }, format: { with: VALID_WORKER_NAME_CALL_REGEX }, allow_blank: true
  validates :sign_name, presence: true, length: { in: 1..6 }

end

