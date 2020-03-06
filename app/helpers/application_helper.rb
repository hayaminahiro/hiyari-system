module ApplicationHelper

  def full_title(page_name = "")
    base_title = "ヒヤリ・事故管理システム"
    if page_name.empty?
      base_title
    else
      page_name + " | " + base_title
    end
  end

end
