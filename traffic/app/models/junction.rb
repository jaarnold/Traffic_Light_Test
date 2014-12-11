# require './lib/traffic_light'

class Junction < ActiveRecord::Base
  
  has_many :traffic_lights, dependent: :destroy

  validates :title, presence: true
  validates :lights, presence: true,
                     numericality: { only_integer: true,  
                     greater_than: 1, 
                     less_than: 5 }

  # Used to initiate cycle! from browser
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

  # Returns correct CSS code for a given light
  def light_up no, colour
    case true
    when traffic_lights[no].state == 'Green'
      if colour == 'Green'
        "green_circle"
      else
        "grey_circle"
      end
    when traffic_lights[no].state == 'Red'
      if colour == 'Red'
        "red_circle"
      else
        "grey_circle"
      end
    when traffic_lights[no].state == 'Orange'
      if colour == 'Orange'
        "orange_circle"
      else
        "grey_circle"
      end
    when traffic_lights[no].state == 'RedOrange'
      if colour == 'Red'
        "red_circle"
      elsif colour == 'Orange'
        "orange_circle"
      else
        "grey_circle"
      end
    else
      'Error'
    end
  end

end
