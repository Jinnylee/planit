class PackingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip, only: [:create, :update, :destroy]

  def index
    @packings = Packing.where(trip_id: params[:trip_id])
    respond_to do |format|
      format.json { render json: @packings }
    end
  end

  def create
    @packing = @trip.packings.new(item: params[:packing])
      if @packing.save
        render json: @packing
      else
        render json: @packing.errors, status: :unprocessable_entity
      end

  end

  def update
    @packing = packing.update(params[:id], packing_params)
    respond_to do |format|
      if @packing.save
        format.json { render json: @packing }
      else
        format.json { render json: @packing.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    Packing.destroy(params[:id])
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    def set_trip
      @trip = Trip.find_by(id: params[:trip_id])
      if @trip.nil?
        render json: {message: "Can't find trip"}, status: 404
      end
    end

end
