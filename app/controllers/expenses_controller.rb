class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip, only: [:create]

  def index
    @expenses = Expense.includes(:expense_splits).where(trip_id: params[:trip_id])
    respond_to do |format|
      format.json { render json: @expenses.as_json(include: { expense_splits: { include: :user }, user: {} })}
    end
  end

  def show
    @expense = Expense.includes(:expense_splits).find(params[:id])
    respond_to do |format|
      format.json { render json: @expense.as_json(include: { expense_splits: { include: :user }, user: {} }) }
    end
  end

  def create
    @expense = @trip.expenses.new(expense_params)

    if @expense.save
      if not params[:expense][:name_list].nil?
        params[:expense][:name_list].each do |user_id| # [3, 5]
          @expense.expense_splits.create(user_id: user_id)
        end
      end

      render json: @expense.as_json(include: {expense_splits: {include: :user} })
    else
      render json: @expense.errors, status: :unprocessable_entity
    end
  end

  def update
    @expense = Expense.update(params[:id], expense_params)


    if @expense.save
      if params[:expense][:name_list].nil?
        @expense.expense_splits.delete_all
      else
        params[:expense][:name_list].each do |user_id| # [3, 5]
          @expense.expense_splits.find_or_create_by(user_id: user_id)
        end
        @expense.expense_splits.where.not(user_id: params[:expense][:name_list]).delete_all
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
      params.require(:expense).permit(:title, :pay_status, :user_id, :amount)
    end

    def set_trip
      @trip = Trip.find_by(id: params[:trip_id])
      if @trip.nil?
        render json: {message: "Trip not found"}, status: 404
      end
    end

end
