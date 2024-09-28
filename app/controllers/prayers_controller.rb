class PrayersController < ApiController
  before_action :authenticate_request

  def create
    @prayer = Prayer.new(prayer_params)
    if @prayer.save
      head :created
    else
      render json: @prayer.errors, status: :unprocessable_entity
    end
  end

  # def show
  #   if Prayer.exists?(params[:id])
  #     @prayer = Prayer.find(params[:id])
  #     render json: @prayer
  #   else
  #     render json: { error: 'Record missing' }, status: :not_found
  #   end
  # end

  def index
    @pagy, @prayers = pagy(Prayer.order(created_at: :desc), limit: 1)

    render json: @prayers
  end

  private

  def prayer_params
    params.require(:prayer).permit(:content)
  end
end
