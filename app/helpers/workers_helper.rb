module WorkersHelper

  #職員情報バリデーション
  def worker_valid?(worker_name, senior_ids)
    worker = false
    if worker_name.present? && senior_ids.reject(&:blank?).count <= 6
      worker = true
    end
    worker
  end

end
