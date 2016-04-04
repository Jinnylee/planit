class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip, only: [:create]

  def index
    @chats = Chat.where(trip_id: params[:trip_id])
    respond_to do |format|
      format.json { render json: @chats }
    end
  end

  def create
    @chat = @trip.chats.new(chat_params)
      if @chat.save
        # render json: @chat

        render json: @chat.as_json(include: :user)
      else
        render json: @chat.errors, status: :unprocessable_entity
      end
  end

  private
    def chat_params
      params.require(:chat).permit(:user_id, :message)
    end

    def set_trip
      @trip = Trip.find_by(id: params[:trip_id])
      if @trip.nil?
        render json: {message: "Trip not found"}, status: 404
      end
    end

end
