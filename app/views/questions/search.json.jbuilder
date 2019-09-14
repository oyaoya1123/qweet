json.array! @questions do |question|
  json.id question.id
  json.title question.title
  json.content question.content
  json.user_name question.user.name
end