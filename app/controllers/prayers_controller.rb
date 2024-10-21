class PrayersController < ApiController
  before_action :authenticate_request

  def pray
    @prayer = Prayer.find(params[:id])
    if @prayer.prayed_by(current_user)
      render json: { error: 'No more than once per user' }, status: :unprocessable_entity
      return
    end

    Prayer.transaction do
      Prayer.increment_counter(:counter, @prayer.id)
      @prayer.prayings.create!(user: current_user)
    end

    @prayer.reload
    render json: @prayer.as_json.merge("user_prayed" => @prayer.prayed_by(User.last)), status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Record not found' }, status: :not_found
  end

  def create
    @prayer = current_user.prayers.build(prayer_params)
    if @prayer.save
      render json: @prayer.as_json.merge("user_prayed" => @prayer.prayed_by(User.last)), status: :created
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

    render json: @prayers.map {|prayer| prayer.as_json.merge("user_prayed" => prayer.prayed_by(User.last))}
  end

  private

  def prayer_params
    params.require(:prayer).permit(:content)
  end
end
