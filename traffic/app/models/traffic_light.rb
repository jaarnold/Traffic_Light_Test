class TrafficLight < ActiveRecord::Base
  belongs_to :junction

  def red!
    if red == false
      puts "/R"
      update red: true
    else
      puts "R"
      update red: false
    end
  end

  def red?
    red
  end

  def orange!
    if orange == true
      update orange: false
    else
      puts "O"
      update orange: true
    end
  end

  def orange?
    orange
  end

  def green!
    if green == true
      update green: false
    else
      puts "G"
      update green: true
      puts green
    end
  end

  def green?
    green
  end

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

