class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update,
                                      :destroy, :reports, :alerts, :new_alert]

  def index
    if params[:search].present?
      LocationFetcher.fetch(params[:search])
      first_word = params[:search].split(/[\s,]+/).first
      @locations = Location.search(first_word).order(updated_at: :desc)
      if @locations.empty?
        flash[:notice] = "\'#{params[:search].capitalize}\' queued for import.
          Please refresh the page if the new location doesn't appear below right away."
      end
      redirect_to locations_path
    else
      @locations = Location.order(updated_at: :desc).paginate(:page => params[:page])
    end
  end

  def show
  end

  def new
    @location = Location.new
  end

  def edit
  end

  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render action: 'show', status: :created, location: @location }
      else
        format.html { render action: 'new' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if (current_user.present? && current_user.admin?)
        if @location.update(location_params)
          format.html { redirect_to @location, notice: 'Location was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @location.errors, status: :unprocessable_entity }
        end
      else
        redirect_to locations_url, alert: 'Not authorized.'
      end
    end
  end

  def destroy
    if (current_user.present? && current_user.admin?)
      @location.destroy
      respond_to do |format|
        format.html { redirect_to locations_url, notice: 'Location was deleted.' }
        format.json { head :no_content }
      end
    else
      redirect_to locations_url, alert: 'Not authorized.'
    end
  end

  def reports
    if @location.weather_reports.blank? || @location.weather_reports.last.created_at < 1.hour.ago
      WeatherFetcher.fetch(@location)
      redirect_to locations_path, notice: "We're fetching weather reports for this location. Click on the 'Show reports' button in a few seconds."
    else
      @weather_reports = @location.weather_reports.order(updated_at: :desc).paginate(:page => params[:page])
    end
  rescue => e
    case e
      when WeatherFetcherError
        redirect_to locations_path, notice: e.message
      when OpenURI::HTTPError
        redirect_to weather_reports_path, notice: "HTTP Error: #{e.message}. Weather service is temporarily down, please try again later or browse most recent reports below."
      else
        raise e
    end
  end

  def alerts
    @location.alerts
  end

  def new_alert
    @location.alerts.new
  end

  private
  def set_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit(
        :woeid, :city_id, :street, :city, :state_code, :state,
        :postal_code, :country_code, :country, :latitude, :longitude)
  end
end
