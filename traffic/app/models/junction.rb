# require './lib/traffic_light'

class Junction < ActiveRecord::Base
  
  has_many :traffic_lights, dependent: :destroy

  validates :title, presence: true
  validates :lights, presence: true,
                     numericality: { only_integer: true,  
                     greater_than: 1, 
                     less_than: 5 }

  def cycle= input
    if input == '1'
      cycle!
    end
  end


  # Cycles all lights to next step simultaneously
  def cycle!
    traffic_lights.each { |light| 
      puts light
      puts light.red  
      light.change }
  end

  # Displays lights in pictoral form
  def pic no
    case true
    when traffic_lights[no].state == 'Green'
      "traffic-lights-green.jpg"
    when traffic_lights[no].state == 'Red'
      "traffic-light-red.jpg"
    when traffic_lights[no].state == 'Orange'
      "traffic-lights-amber.jpg"
    when traffic_lights[no].state == 'RedOrange'
      "traffic-lights-red-amber.jpg"
    else
      'Error'
    end
  end

end
