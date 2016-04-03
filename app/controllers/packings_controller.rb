class PackingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip, only: [:create]

  def index
    @packings = Packing.includes(:packing_splits).where(trip_id: params[:trip_id])
    respond_to do |format|
      format.json { render json: @packings.as_json(include: { packing_splits: { include: :user }, user: {} })}
    end
  end

  def create
    @packing = @trip.packings.new(packing_params)
    @packing.name = params["packing"]["name"]["name"]

    if @packing.save
      params[:packing][:name_list].each do |user_id| # [3, 5]
        @packing.packing_splits.create(user_id: user_id)
      end

      render json: @packing.as_json(include: {packing_splits: {include: :user} })
    else
      render json: @packing.errors, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
    PackingSplit.destroy_all(packing_id: params[:id])
    Packing.destroy(params[:id])
    respond_to do |format|
      # format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def packing_params
      params.require(:packing).permit(:description)
    end

    def set_trip
      @trip = Trip.find_by(id: params[:trip_id])
      if @trip.nil?
        render json: {message: "Trip not found"}, status: 404
      end
  end

end
