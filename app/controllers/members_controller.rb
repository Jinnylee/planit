class MembersController < ApplicationController

  def index
    @members = UserTrip.includes(:user).where(trip_id: params[:id])
    respond_to do |format|
      format.json { render '' }
    end
  end

  def create
    @member = User.find(email: member_params)
    respond_to do |format|
      if @member = nil
        Invitation.create(email: member_params, trip_id: )
      else
        UserTrip.create(user_id: , trip_id: )
      end
    end
  end

  def update
  end

  def destroy
  end

  private
    def member_params
      params.require(:member).permit(:email)
    end

end
