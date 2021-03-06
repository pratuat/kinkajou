class FilterUsersByProximityService
  extend Callable

  TARGET_LOCATION = {lat: 52.508283, lon: 13.329657}
  EARTH_RADIUS = 6371
  PROXIMITY_THRESHOLD = 100

  def initialize(user_locations)
    @user_locations = user_locations
  end

  def call
    filtered_user_ids = @user_locations.filter do |user_location|
      geodesic_distance(user_location['latitude'], user_location['longitude']) < PROXIMITY_THRESHOLD
    end.map {|user_info| user_info.slice('user_id', 'name')}

    return filtered_user_ids
  end

  def geodesic_distance(loc_lat, loc_lon)
    d_lat = (TARGET_LOCATION[:lat]-loc_lat) * 0.017453292519943295
    d_lon = (TARGET_LOCATION[:lon]-loc_lon) * 0.017453292519943295

    temp = (Math.sin(d_lat/2))**2 + Math.cos(TARGET_LOCATION[:lat])*Math.cos(loc_lat)*(Math.sin(d_lon/2))**2

    return 2 * Math.asin(Math.sqrt(temp)) * EARTH_RADIUS
  end
end