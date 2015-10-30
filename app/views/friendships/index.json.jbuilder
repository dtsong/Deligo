json.array!(@friendships) do |friendship|
  json.extract! friendship, :id, :user_id1, :user_id2
  json.url friendship_url(friendship, format: :json)
end
