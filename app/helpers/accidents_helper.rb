module AccidentsHelper

  #value(checkboxにチェックが入ってれば文字列があるはず)が存在すればtrue, 無ければfalseをreturn
  def checkbox_judgment(value)
    value ? true : false
  end

  #7:00~9:00で時間範囲限定
  def time_range_7_9(time)
    time.accident_time.strftime("%k").gsub(" ", "").to_i >= 7 && time.accident_time.strftime("%k").gsub(" ", "").to_i < 9
  end

  #9:00~12:00で時間範囲限定
  def time_range_9_12(time)
    time.accident_time.strftime("%k").gsub(" ", "").to_i >= 9 && time.accident_time.strftime("%k").gsub(" ", "").to_i < 12
  end

  #12:00~14:00で時間範囲限定
  def time_range_12_14(time)
    time.accident_time.strftime("%k").gsub(" ", "").to_i >= 12 && time.accident_time.strftime("%k").gsub(" ", "").to_i < 14
  end

  #14:00~17:00で時間範囲限定
  def time_range_14_17(time)
    time.accident_time.strftime("%k").gsub(" ", "").to_i >= 14 && time.accident_time.strftime("%k").gsub(" ", "").to_i < 17
  end

  #17:00~19:00で時間範囲限定
  def time_range_17_19(time)
    time.accident_time.strftime("%k").gsub(" ", "").to_i >= 17 && time.accident_time.strftime("%k").gsub(" ", "").to_i < 19
  end

  #19:00~22:00で時間範囲限定
  def time_range_19_22(time)
    time.accident_time.strftime("%k").gsub(" ", "").to_i >= 19 && time.accident_time.strftime("%k").gsub(" ", "").to_i < 22
  end

  #22:00~3:00で時間範囲限定
  def time_range_22_03(time)
    time.accident_time.strftime("%k").gsub(" ", "").to_i >= 22 || time.accident_time.strftime("%k").gsub(" ", "").to_i < 3
  end

  #3:00~7:00で時間範囲限定
  def time_range_3_7(time)
    time.accident_time.strftime("%k").gsub(" ", "").to_i >= 3 && time.accident_time.strftime("%k").gsub(" ", "").to_i < 7
  end


end
