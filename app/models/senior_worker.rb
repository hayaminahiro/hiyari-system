class SeniorWorker < ApplicationRecord
  belongs_to :worker
  belongs_to :senior
end
