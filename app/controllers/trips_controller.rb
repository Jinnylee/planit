class TripsController < ApplicationController

  def index
    @trips = Trip.all
    respond_to do |format|
      format.json { render 'index.jbuilder' }
    end
  end

  def create
    @trip = Trip.new(trip_params)
    respond_to do |format|
      if @trip.save
        format.json { render json: @trip }
      else
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @trip = Trip.update(params[:id], trip_params)
    respond_to do |format|
      if @trip.save
        format.json { render json: @trip }
      else
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    Trip.destroy(params[:id])
    respond_to do |format|
      # format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def trip_params
      params.require(:trip).permit(:location, :start_date, :end_date)
    end

    # def editedtrip_params
    #   params.require(:editedtrip).permit(:location, :start_date, :end_date)
    # end

end
