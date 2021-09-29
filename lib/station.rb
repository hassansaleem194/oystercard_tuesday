require './zones'

class Station 
  include TflZones

  attr_reader :name, :zone

  def initialize(name, zone = ZONE1)
    @name = name
    @zone = zone
    @not_readable = "Shhh its a secret!"
  end

end
