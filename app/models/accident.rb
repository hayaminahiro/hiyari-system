class Accident < ApplicationRecord
  belongs_to :senior
  #belongs_to :senior, optional: true

  validates :which_accident, presence: true
  #validates :reporter, presence: true
  #validates :accident_datetime, presence: true
  #validates :accident_senior, presence: true
  #validates :accident_scene, presence: true

  enum accident_result: {ヒヤリのみ:1, 軽事故等:2}

end


#validates :account_id, presence: true
#validates :account, presence: true, if: -> { account_id.present? }