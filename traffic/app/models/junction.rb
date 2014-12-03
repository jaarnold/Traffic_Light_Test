require './lib/traffic_light'

class Junction < ActiveRecord::Base
  validates :title, presence: true
  validates :lights, presence: true,
                     numericality: { only_integer: true,  
                     greater_than: 1, 
                     less_than: 5 }
  serialize :seq

  def setup (num)
    # Storage for lights
    # Currently limited to up to four lights, lights 0,2 are a pair and lights 1, 3 are a pair
    @seq = []
    num.times { add_light }
    # Checks each light, sets lights lights 0 & 2 to be green initially
    @seq.each { |light|
      if @seq.index(light) % 2 == 0
        light.green!
        light.red!
      end
    }
  end

  # Cycles all lights to next step simultaneously
  def cycle(arr); arr.each { |light| light.change } end

  # Returns array of lights that are on for a given light designated by 'no'
  def check(arr, no); arr[no].state; end

  # Builds red, orange and green methods which return true if the given colour is on for the given light
  [:red, :orange, :green].each { |colour|
    define_method ("#{colour}") do |no|
      check(no).include?(colour)
    end
  }

  def pic (arr)
    case true
    when arr == [:green]
      "traffic-lights-green.jpg"
    when arr == [:red]
      "traffic-light-red.jpg"
    when arr == [:orange]
      "traffic-lights-amber.jpg"
    when arr == [:red, :orange]
      "traffic-lights-red-amber.jpg"
    else
      'Error'
    end
  end

  private

  # Add a traffic light to the junction, hidden method
  def add_light
    @seq << TrafficLight.new
  end

end
