json.array! @trips do |trip|
  json.id trip.id
  json.location trip.location
  json.start_date trip.start_date
  json.end_date trip.end_date
  json.title trip.title
end