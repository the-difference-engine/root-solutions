json.array!(@building_blocks) do |building_block|
  json.extract! building_block, :id, :name
  json.url building_block_url(building_block, format: :json)
end
