module GroupsHelper

  def latest_comment(group)
    if group.messages.last.blank?
      'メッセージがありません'
    elsif group.messages.last.text.blank?
      '画像が投稿されています'
    else
      group.messages.last.text
    end
  end

end
