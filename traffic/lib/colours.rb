module Colours

  def colours *colour

    @colour_set = []

    colour.each { |hue|

      @colour_set << hue

      define_method("#{hue}" + '!') do

        instance_variable_set("@#{hue}", !instance_variable_get("@#{hue}"))
        
      end

      define_method("#{hue}" + '?') do 
        instance_variable_get "@#{hue}"
      end

    }

  end

end



