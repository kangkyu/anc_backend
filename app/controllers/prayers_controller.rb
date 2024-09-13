class PrayersController < ApiController
  def create
    @prayer = Prayer.new(prayer_params)
    if @prayer.save
      head :created
    else
      render json: @prayer.errors, status: :unprocessable_entity
    end
  end

  def show
    if Prayer.exists?(params[:id])
      @prayer = Prayer.find(params[:id])
      render json: @prayer
    else
      render json: { error: 'Record missing' }, status: :not_found
    end
  end

  private

  def prayer_params
    params.require(:prayer).permit(:content)
  end
end
