class MembersController < ApplicationController
  before_action :authenticate_user!, except: [:join_by_hash]
  before_action :set_user, only: [:join_by_hash]
  before_action :set_trip, only: [:create, :update, :destroy]
  before_action :set_invitation, only: [:join_by_hash]

  def index
    @members = Trip.find_by(id: params[:trip_id]).users
    respond_to do |format|
      format.json { render json: @members }
    end
  end

  def create
    @member = User.find_by(email: params[:email])
    if @member.nil?
      secure_hash = SecureRandom.urlsafe_base64
      @invitation = @trip.invitations.find_or_create_by(email: params[:email], secure_hash: secure_hash)
      UserMailer.invitation(params[:email], @invitation.secure_hash, @current_user).deliver_now
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
    # UserTrip.destroy(trip_id: params[:trip_id], user_id: params[:user_id])
    # respond_to do |format|
    #   # format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  def join_by_hash
    user_trip = @user.user_trips.new(trip_id: @invitation.trip_id)
    if user_trip.save
      @invitation.update(used: true)
      render json: {message: "Added to Group"}
    else
      render json: {message: "Can't save", errors: user_trip.errors.messages}, status: 400
    end
  end

  def pending
    @pending = Invitation.find_by(trip_id: params[:trip_id], used: false)
    respond_to do |format|
      format.json { render json: @pending }
    end
  end


private
  def set_user
    @user = User.find_by(id: params[:user_id])
    if @user.nil?
      render json: {message: "Can't find user"}, status: 404
    end
  end

  def set_invitation
    @invitation = Invitation.find_by(secure_hash: params[:secure_hash])
    if @invitation.nil?
      render json: {message: "Can't find invitation"}, status: 404
    end
  end

  def set_trip
    @trip = Trip.find_by(id: params[:trip_id])
    if @trip.nil?
      render json: {message: "Can't find trip"}, status: 404
    end
  end

end
