class JunctionsController < ApplicationController

  def new
    @junction = Junction.new
  end

  def create
    @junction = Junction.new(junction_params)

    if @junction.save
      @junction.id

      @junction.lights.times do |count| 
        @junction.traffic_lights.create red: true, orange: false, green: false
        if count.even?
          @junction.traffic_lights[count].red!
          @junction.traffic_lights[count].green!
        end
      end
      redirect_to @junction
    else
      render 'new'
    end
  end

  def show
    @junction = Junction.find(params[:id])
  end

  def index
    @junctions = Junction.all
  end

  def edit
    @junction = Junction.find(params[:id])
  end

  def update
    @junction = Junction.find(params[:id])

    if @junction.update(junction_params)
      if request.xhr?
        render js: "window.location.pathname = #{junction_path(@junction.id).to_json}"
      else
        redirect_to @junction
      end
    else
      render 'edit'
    end
  end

  def destroy
    @junction = Junction.find(params[:id])
    @junction.destroy

    redirect_to junctions_path
  end


  private

    def junction_params
      params.require(:junction).permit(:title, :lights, :cycle)
    end

end
