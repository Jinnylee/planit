class FlightsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip, only: [:create]

  def index
    @flights = Flight.includes(:flight_splits).where(trip_id: params[:trip_id])
    respond_to do |format|
      format.json { render json: @flights.as_json(include: { flight_splits: { include: :user }, user: {} })}
    end
  end

  def show
    @flight = Flight.includes(:flight_splits).find(params[:id])
    respond_to do |format|
      format.json { render json: @flight.as_json(include: { flight_splits: { include: :user }, user: {} }) }
    end
  end

  def create
    @flight = @trip.flights.new(flight_params)

    if @flight.save
      params[:flight][:name_list].each do |user_id| # [3, 5]
        @flight.flight_splits.create(user_id: user_id)
      end

      render json: @flight.as_json(include: {flight_splits: {include: :user} })
    else
      render json: @flight.errors, status: :unprocessable_entity
    end
  end

  def update
    @flight = Flight.update(params[:id], flight_params)

    if @flight.save
      if params[:flight][:name_list].nil?
        @flight.flight_splits.delete_all
      else
        params[:flight][:name_list].each do |user_id|
          @flight.flight_splits.find_or_create_by(user_id: user_id)
        end
      @flight.flight_splits.where.not(user_id: params[:flight][:name_list]).delete_all
      end
      render json: @flight.as_json(include: { flight_splits: {include: :user} })
    else
      render json: @flight.errors, status: :unprocessable_entity
    end
  end

  def destroy
    FlightSplit.destroy_all(flight_id: params[:id])
    Flight.destroy(params[:id])
    respond_to do |format|
      # format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def flight_params
      params.require(:flight).permit(:airline, :arrival_airport, :arrival_date, :departure_airport, :departure_date, :flight_number, :terminal, :user_id)
    end

    def set_trip
      @trip = Trip.find_by(id: params[:trip_id])
      if @trip.nil?
        render json: {message: "Trip not found"}, status: 404
      end
    end

end
