class Worker < ApplicationRecord
  belongs_to :facility

  validates :worker_name, presence: true, length: { in: 1..20 }
  VALID_WORKER_NAME_CALL_REGEX = /\A[ぁ-んァ-ヶー－]+\z/
  validates :worker_name_call, length: { in: 1..20 }, format: { with: VALID_WORKER_NAME_CALL_REGEX }
  validates :sign_name, presence: true, length: { in: 1..5 }

end
