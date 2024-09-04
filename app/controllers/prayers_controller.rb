class PrayersController < ApplicationController

  def create
    token = token_from_request

    return if performed?

    validation_response = Auth0Client.validate_token(token)

    if error = validation_response.error
      render(json: { message: error.message }, status: error.status) and return
    end

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
    params.require(:prayer).permit(:content, :auth0_user_id)
  end
end
