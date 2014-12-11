class TrafficLightsController < ApplicationController

	def create
		@junction = Junction.find(params[:junction_id])
		@traffic_light = @junction.traffic_lights.create(params[:traffic_light])
	end

	def edit
    	@junction = Junction.find(params[:junction_id])
		@traffic_light = @junction.traffic_lights.create(params[:traffic_light])
  	end

  	def update
    	@junction = Junction.find(params[:junction_id])
		@traffic_light = @junction.traffic_lights.create(params[:traffic_light])

	    if @traffic_light.update(params[:traffic_light])
    	  redirect_to @junction
   		else
      	  render 'edit'
    	end
  	end

	def destroy
		@junction = Junction.find(params[:junction_id])
		@traffic_light = @junction.traffic_lights.find(params[:id])
		@traffic_light.destroy
	end

end
