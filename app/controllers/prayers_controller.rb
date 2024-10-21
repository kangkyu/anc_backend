class PrayersController < ApiController
  before_action :authenticate_request

  def pray
    @prayer = Prayer.find(params[:id])

    Prayer.transaction do
      Prayer.increment_counter(:counter, @prayer.id)
      Praying.create!(user: current_user, prayer: @prayer)
    end

    @prayer.reload
    render json: @prayer, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Record not found' }, status: :not_found
  end

  def create
    @prayer = current_user.prayers.build(prayer_params)
    if @prayer.save
      render json: @prayer, status: :created
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
