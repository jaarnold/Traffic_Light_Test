require './lib/traffic_light'

class Junction < ActiveRecord::Base
  validates :title, presence: true
  validates :lights, presence: true,
                     numericality: { only_integer: true,  
                     greater_than: 1, 
                     less_than: 5 }
  serialize :seq

  def setup num
    # Storage for lights
    # Currently limited to up to four lights, lights 0,2 are a pair and lights 1, 3 are a pair
    cycle = 0
    seq = []
    num.times { seq << TrafficLight.new }
    # Checks each light, sets lights lights 0 & 2 to be green initially
    seq.each { |light|
      if seq.index(light) % 2 == 0
        light.green!
        light.red!
      end
    }
  end

  def cycle= input
    if input == '1'
      cycle!
    end
  end


  # Cycles all lights to next step simultaneously
  def cycle!
    seq.each { |light| light.change }
  end

  # Returns array of lights that are on for a given light designated by 'no'
  def check no
    seq[no].state
  end

  # Builds red, orange and green methods which return true if the given colour is on for the given light
  [:red, :orange, :green].each { |colour|
    define_method ("#{colour}") do |no|
      check(no).include?(colour)
    end
  }

  def pic no
    case true
    when check(no) == [:green]
      "traffic-lights-green.jpg"
    when check(no) == [:red]
      "traffic-light-red.jpg"
    when check(no) == [:orange]
      "traffic-lights-amber.jpg"
    when check(no) == [:red, :orange]
      "traffic-lights-red-amber.jpg"
    else
      'Error'
    end
  end

end
