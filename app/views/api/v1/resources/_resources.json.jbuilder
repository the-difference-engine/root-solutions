json.id resource.id
json.title resource.title
json.author resource.author
json.news_source resource.news_source
json.date resource.date
json.url resource.url
json.abstract resource.abstract
json.content resource.content
json.admin_notes resource.admin_notes
json.is_published resource.is_published
json.is_problem resource.is_problem
json.world_region WorldRegion.find_by(id: resource.world_region_id).name
json.news_source NewsSource.find_by(id: resource.news_source_id).name
json.resource_type ResourceType.find_by(id: resource.resource_type_id).name
json.cognitive_bium CognitiveBium.find_by(id: resource.cognitive_bium_id).name
json.academic_citation resource.academic_citation
json.source resource.source
json.length resource.length
json.created_at resource.created_at
json.updated_at resource.updated_at
