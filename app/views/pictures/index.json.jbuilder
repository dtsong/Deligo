json.array!(@pictures) do |picture|
  json.extract! picture, :id, :question_id, :picture_url
  json.url picture_url(picture, format: :json)
end
