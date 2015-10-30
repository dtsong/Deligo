json.array!(@answers) do |answer|
  json.extract! answer, :id, :answerer_id, :comments, :picture_url, :answer_option_id
  json.url answer_url(answer, format: :json)
end
