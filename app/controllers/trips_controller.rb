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
  end

  def destroy
  end

end
