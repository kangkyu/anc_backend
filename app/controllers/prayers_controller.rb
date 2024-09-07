class PrayersController < ApplicationController
  protect_from_forgery with: :null_session # For private controllers only
  include Secured

  before_action :authorize

  def create
    @prayer = Prayer.new(prayer_params)
    if @prayer.save
      head :created
    else
      render json: @prayer.errors, status: :unprocessable_entity
    end
  end

  def show
    @prayer = Prayer.find(params[:id])
  end

  def pray
    @prayer = Prayer.find(params[:id])
    # TODO
  end

  private

  def prayer_params
    params.require(:prayer).permit(:content).merge(auth0_user_id: auth0_user_id)
  end
end
