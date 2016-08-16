json.array!(@building_block_substeps) do |building_block_substep|
  json.extract! building_block_substep, :id, :name, :building_block_id
  json.url building_block_substep_url(building_block_substep, format: :json)
end
