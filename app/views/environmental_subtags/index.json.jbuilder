json.array!(@environmental_subtags) do |environmental_subtag|
  json.extract! environmental_subtag, :id, :name
  json.url environmental_subtag_url(environmental_subtag, format: :json)
end
