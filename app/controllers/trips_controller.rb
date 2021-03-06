class TripsController < ApplicationController
  before_action :authenticate_user!

  def index
    @trips = current_user.trips.order(created_at: :desc)
    respond_to do |format|
      format.json { render 'index.jbuilder' }
    end
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.location = params["trip"]["location"]["name"]
    respond_to do |format|
      if @trip.save
        format.json { render json: @trip }
      else
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
    @trip.user_trips.create(user_id: current_user.id)
  end

  def update
    @trip = Trip.update(params[:id], trip_params)
    @trip.location = params["trip"]["location"]["name"]
    respond_to do |format|
      if @trip.save
        format.json { render json: @trip }
      else
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    UserTrip.destroy_all(trip_id: params[:id])
    Trip.destroy(params[:id])
    respond_to do |format|
      # format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_users
    @users = UserTrip.includes(:user).where(trip_id: params[:trip_id]).map(&:user)
    respond_to do |format|
      format.json { render json: @users }
    end
  end

  def get_specific_trip
    @trip = Trip.find(params[:trip_id])
    respond_to do |format|
      format.json { render json: @trip }
    end
  end

  private
    def trip_params
      params.require(:trip).permit(:start_date, :end_date, :title, :id)
    end

    # def editedtrip_params
    #   params.require(:editedtrip).permit(:location, :start_date, :end_date)
    # end

end
