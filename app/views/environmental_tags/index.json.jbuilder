json.array!(@environmental_tags) do |environmental_tag|
  json.extract! environmental_tag, :id, :name
  json.url environmental_tag_url(environmental_tag, format: :json)
end
