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
      なし: 0, ２F主任: 1, ３F主任: 2, ４F主任: 3, ２F係長: 4, ３F係長: 5, ４F係長: 6, リスマネ: 7, 次長: 8, 施設長: 9
  }

end

