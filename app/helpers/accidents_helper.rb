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

end
