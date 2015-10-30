json.array!(@answer_options) do |answer_option|
  json.extract! answer_option, :id, :question_id, :option
  json.url answer_option_url(answer_option, format: :json)
end
