json.array!(@groups) do |group|
  json.extract! group, :id, :creator_id, :name, :description, :active
  json.url group_url(group, format: :json)
end
