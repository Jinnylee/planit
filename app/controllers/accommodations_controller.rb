class AccommodationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip, only: [:create]

  def index
    @accommodations = Accommodation.includes(:accommodation_splits).where(trip_id: params[:trip_id])
    respond_to do |format|
      format.json { render json: @accommodations.as_json(include: { accommodation_splits: { include: :user }, user: {} })}
    end
  end

  def create
    @accommodation = @trip.accommodations.new(accommodation_params)
    @accommodation.name = params["accommodation"]["name"]["name"]

    if @accommodation.save
      params[:accommodation][:name_list].each do |user_id| # [3, 5]
        @accommodation.accommodation_splits.create(user_id: user_id)
      end

      render json: @accommodation.as_json(include: {accommodation_splits: {include: :user} })
    else
      render json: @accommodation.errors, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
    AccommodationSplit.destroy_all(accommodation_id: params[:id])
    Accommodation.destroy(params[:id])
    respond_to do |format|
      # format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def accommodation_params
      params.require(:accommodation).permit(:description, :price, :check_in, :check_out, :confirmation_number)
    end

    def set_trip
      @trip = Trip.find_by(id: params[:trip_id])
      if @trip.nil?
        render json: {message: "Trip not found"}, status: 404
      end
    end

end
