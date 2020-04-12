class Accident < ApplicationRecord
  belongs_to :senior

  validates :which_accident, presence: true
  validates :accident_time, presence: true
  validates :accident_scene, presence: true

  enum accident_result: {ヒヤリのみ:1, 軽事故等:2}

  enum activity_scene:{
      通所・送迎: 0, 活動・支援（施設内・外出）: 1, 給食・配膳: 2, トイレ・排泄: 3, 入浴: 4, その他: 5
  }

end