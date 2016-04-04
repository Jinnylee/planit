class PackingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @packings = Packing.all
    respond_to do |format|
      format.json { render json: @packings }
    end
  end

  def create
    @packing = Packing.new(packing_params)
    respond_to do |format|
      if @packing.save
        format.json { render json: @packing }
      else
        format.json { render json: @packing.errors, status: :unprocessable_entity }
      end
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
    Userpacking.destroy_all(packing_id: params[:id])
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

  private
    def packing_params
      params.require(:packing)
    end

    # def editedpacking_params
    #   params.require(:editedtrip).permit(:location, :start_date, :end_date)
    # end

end
