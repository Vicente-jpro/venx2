module ApplicationHelper
 def cities_array_empty
      city = City.new
      @cities = []
      @cities << city
      @cities
   end
end
