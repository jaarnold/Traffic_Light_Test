# require_relative 'colours'

class TrafficLight < ActiveRecord::Base

  belongs_to :junction

  # extend Colours # may need to implement using extend first

  # macro which defines red? and red! etc automatically
  # colours :red, :orange, :green

  # def self.colour_set
  #   @colour_set
  # end

  # def colour_set
  #   self.class.colour_set
  # end

  def red!
    if red == true
      red = false
    else
      red = true
    end
  end

  def red?
    red
  end

  def orange!
    if orange == true
      orange = false
    else
      orange = true
    end
  end

  def orange?
    orange
  end

  def green!
    if green == true
      green = false
    else
      green = true
    end
  end

  def green?
    green
  end

  # def initialize
  #   red! 
  # end

  def change
    case true
    #  Red to Red & Orange
    when red? && !orange? && !green?
      orange!  
    # Red & Orange to Green
    when red? && orange? && !green?
      red! 
      orange! 
      green! 
    # Green to Orange
    when !red? && !orange? && green?
      orange!
      green!
    # Orange to Red
    when !red? && orange? && !green?
      red! 
      orange! 
    # If illegal setup  
    else
      puts 'Error, please Reset'
    end
  end

  def reset
    # Reset lights to [red]
    red! if !red? 
    orange! if orange? 
    green! if green? 
  end

  # def order
  #   # Forces  into order of Red, Orange, Green
  #   @colour_set.each { |hue|
  #     if .any? { |tint| tint == hue }
  #       .delete(hue)
  #       .push(hue)
  #     end
  #   }
  #   return 
  # end

# returns a clear written output of which lights are on
  def state
    # colour_set.select {|sym| send(sym) }
    case true
    #  Red
    when red? && !orange? && !green?
      'Red'  
    # Red & Orange
    when red? && orange? && !green?
      'RedOrange'
    # Green
    when !red? && !orange? && green?
      'Green'
    # Orange
    when !red? && orange? && !green?
      'Orange' 
    # If illegal setup  
    end
  end

end
