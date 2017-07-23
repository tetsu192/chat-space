module GroupsHelper

  def latest_comment(a_group)
      if a_group.messages.last.blank?
        'メッセージがありません'
      elsif a_group.messages.last.text.blank?
        '画像が投稿されています'
      else
        a_group.messages.last.text
      end
  end

end
