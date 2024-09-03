class PrayersController < ApplicationController
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
end
