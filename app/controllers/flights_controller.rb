class FlightsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip, only: [:create]

  def index
    @accommodations = Accommodation.includes(:accommodation_splits).where(trip_id: params[:trip_id])
    respond_to do |format|
      format.json { render json: @accommodations.as_json(include: { accommodation_splits: { include: :user }, user: {} })}
    end
  end

  def create
  end

  def update
  end

  def destroy
  end

end
