class MembersController < ApplicationController
  before_action :set_trip, only: [:create, :update, :destroy]

  def index
    @members = Trip.find_by(id: params[:trip_id]).users
    respond_to do |format|
      format.json { render json: @members }
    end
  end

  def create
    @member = User.find_by(email: member_params)
    if @member = nil
      @trip.invitations.create(email: member_params)
    else
      @trip.user_trips.create(user_id: @member.id)
    end

    respond_to do |format|
      format.json { render json: {message: "invitation completed"}}
    end
  end

  def update
  end

  def destroy
  end

private
  def set_trip
    @trip = Trip.find_by(id: params[:trip_id])
    if @trip.nil?
      render json: {message: "Can't find trip"}
    end
  end

  def member_params
    params.require(:invitedmembers).permit(:email)
  end

end
