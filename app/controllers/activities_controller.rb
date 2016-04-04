class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip, only: [:create]

  def index
  end

  def create
    @activity = @trip.activities.new(activity_params)

    if @activity.save
      render json: @activity
    else
      render json: @activity.errors, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
    Activity.destroy(params[:id])
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    def activity_params
      params.require(:activity).permit(:title, :description, :date, :time, :location, :link, :price)
    end

    def set_trip
      @trip = Trip.find_by(id: params[:trip_id])
      if @trip.nil?
        render json: {message: "Trip not found"}, status: 404
      end
    end

end
