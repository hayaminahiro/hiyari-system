module AccidentsHelper

  #value(checkboxにチェックが入ってれば文字列があるはず)が存在すればtrue, 無ければfalseをreturn
  def checkbox_judgment(value)
    value ? true : false
  end

  #場面の総合計計算
  def total_scene(service, support, lunch, toilet, bathing, other_scene)
    (service + support + lunch + toilet + bathing + other_scene).count
  end

end
