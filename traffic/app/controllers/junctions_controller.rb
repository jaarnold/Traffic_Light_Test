class JunctionsController < ApplicationController

  def new
    @junction = Junction.new
  end

  def create
    @junction = Junction.new(junction_params)

    if @junction.save
      # Need to figure out how to store @seq variable for each junction 
      # for persistant lights
      @junction.seq = @junction.setup @junction.lights
      @junction.save
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
      redirect_to @junction
    else
      render 'edit'
    end
  end

  def destroy
    @junction = Junction.find(params[:id])
    @junction.destroy

    redirect_to junctions_path
  end

  def next
    @junction = Junction.find(params[:id])
    @junction.cycle @junction.seq
    @junction.save
    redirect_to @junction
  end


  private
    def junction_params
      params.require(:junction).permit(:title, :lights)
    end

end
