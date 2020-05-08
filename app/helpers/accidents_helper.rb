module AccidentsHelper

  #value(checkboxにチェックが入ってれば文字列があるはず)が存在すればtrue, 無ければfalseをreturn
  def checkbox_judgment(value)
    value ? true : false
  end

  #出来事の総合計計算
  def total_event(fall, missing, meal, medicine, scratch, environment, info_contact,
                  personal_info, lost, damage, money, medical_care, infection, forget, other)
    (fall + missing + meal + medicine + scratch + environment + info_contact +
        personal_info + lost + damage + money + medical_care + infection + forget + other).count
  end

  #場面の総合計計算
  def total_scene(service, support, lunch, toilet, bathing, other_scene)
    (service + support + lunch + toilet + bathing + other_scene).count
  end

  #各階係長判定
  def chief_judgment(floor, chief)
    judgment = false
    if floor == 2 && chief.present?
      judgment = true
    elsif floor == 3 && chief.present?
      judgment = true
    elsif floor == 4 && chief.present?
      judgment = true
    end
    judgment
  end

  #最終確認サイン表出のタイミング
  def last_sign(a, b, c, charge_sign, chief)
    last_sign = false
    if a.present? && b.present? && c.present? && charge_sign.present? && chief.present?
      last_sign = true
    end
    last_sign
  end

end
