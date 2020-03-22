module SeniorsHelper

  #利用者情報バリデーション
  def senior_valid?(senior_name, worker_ids)
    senior = false
    if senior_name.present? and worker_ids.reject(&:blank?).count == 1 || worker_ids.reject(&:blank?).count == 2
      senior = true
    end
    senior
  end

end
