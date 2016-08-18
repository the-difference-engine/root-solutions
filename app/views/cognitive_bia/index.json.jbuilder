json.array!(@cognitive_bia) do |cognitive_bium|
  json.extract! cognitive_bium, :id, :name
  json.url cognitive_bium_url(cognitive_bium, format: :json)
end
