json.array!(@world_regions) do |world_region|
  json.extract! world_region, :id, :name
  json.url world_region_url(world_region, format: :json)
end
