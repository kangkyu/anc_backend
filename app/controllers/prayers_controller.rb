class PrayersController < ApplicationController

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

  private

  def prayer_params
    params.require(:prayer).permit(:content)
  end
end
