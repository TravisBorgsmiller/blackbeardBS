require 'twilio-ruby'


class AppsController < ApplicationController
  protect_from_forgery with: :null_session, only: [:create]
  skip_before_action :verify_authenticity_token

  def index
    @apps = App.all
  end

  def show
    @app = App.find(params[:id])
  end

  def new
    @app = App.new
  end

  def edit
    @app = App.find(params[:id])
  end

  def update
    @app = App.find(params[:id])

    if @app.update(app_params)
      redirect_to app_path(@app)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @app = App.new(app_params)
    if @app.save
      flash[:notice] = "#{@app.name} entered in queue!"

      spot_count = App.all.count

      client = Twilio::REST::Client.new(
        Rails.application.credentials.live_sid,  
        Rails.application.credentials.live_auth
      )
      client.messages.create(
        body: "Welcome #{@app.name}, you are #{spot_count} in line!",
        from: Rails.application.credentials.phone_number,
        to: @app.number
        )

      redirect_to new_app_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @app = App.find(params[:id])
    @app.destroy

    redirect_to root_path, status: :see_other
  end

  private
  def app_params
    params.require(:app).permit(:name, :number, :payment, :service)
  end
end
# spot_count = App.all.count

# client = Twilio::REST::Client.new

# message = client.messages.create(
#   to: "#{@app.number}", # Replace with the recipient's phone number
#   from: Rails.application.credentials.phone_number, # Replace with your Twilio phone number
#   body: "You are now in the queue for BlackBeard Barber Shop. You are #{spot_count}th in line"
# )