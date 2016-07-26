json.array! @resources do |resource|
  json.partial! 'resources', resource: resource
end
