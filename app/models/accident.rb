class Accident < ApplicationRecord
  belongs_to :senior

  validates :which_accident, presence: true
  #validates :reporter, presence: true
  #validates :accident_datetime, presence: true
  #validates :accident_senior, presence: true
  validates :accident_scene, presence: true

  enum accident_result: {ヒヤリのみ:1, 軽事故等:2}

end