json.messages @messages.each do |message|
  json.user_name     message.user.name
  json.date     message.created_at.strftime('%y/%m/%d %H:%M')
  json.text     message.text
  json.image    message.image
  json.id       message.id
end
