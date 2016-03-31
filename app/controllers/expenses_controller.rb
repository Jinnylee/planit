class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip, only: [:create]

  def index
    @expenses = Expense.includes(:expense_splits).where(trip_id: params[:trip_id])
    respond_to do |format|
      format.json { render json: @expenses.as_json(include: { expense_splits: { include: :user }, user: {} })}
    end
  end

  def create
    @expense = @trip.expenses.new(expense_params)

    if @expense.save
      params[:expense][:name_list].each do |user_id| # [3, 5]
        @expense.expense_splits.create(user_id: user_id)
      end

      render json: @expense.as_json(include: {expense_splits: {include: :user} })
    else
      render json: @expense.errors, status: :unprocessable_entity
    end
  end

  def update
    @expense = Expense.update(params[:id], expense_params)

    if @expense.save
      params[:expense][:name_list].each do |user_id| # [3, 5]
        @expense.expense_splits.create(user_id: user_id)
      end

      render json: @expense.as_json(include: {expense_splits: {include: :user} })
    else
      render json: @expense.errors, status: :unprocessable_entity
    end
  end

  def destroy
    ExpenseSplit.destroy_all(expense_id: params[:id])
    Expense.destroy(params[:id])
    respond_to do |format|
      # format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    def expense_params
      params.require(:expense).permit(:title, :status, :user_id, :amount)
    end

    def set_trip
      @trip = Trip.find_by(id: params[:trip_id])
      if @trip.nil?
        render json: {message: "Trip not found"}, status: 404
      end
    end

end
