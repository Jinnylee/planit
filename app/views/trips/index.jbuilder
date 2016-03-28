json.array! @trips do |trip|
  json.id trip.id
  json.title trip.location
  json.content trip.start_date
  json.category trip.end_date
end