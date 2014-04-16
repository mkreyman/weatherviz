class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy, :reports]

  def index
    if params[:search]
      WeatherFetcher.fetch(params[:search])
      sanitized_search = params[:search].split(/[\s,]+/).first.strip
      @locations = Location.search(sanitized_search).order(city: :asc)
      if @locations.blank?
        redirect_to locations_path # , notice: 'Sorry, no results found.'
      else
        @locations
      end
    else
      @locations = Location.order(city: :asc)
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
    WeatherFetcher.fetch(@location.city)
    if @location.weather_reports.blank?
      redirect_to root_path, notice: 'Sorry, no results found.'
    else
      @location.weather_reports
    end
  end

  private
    def set_location
      @location = Location.find(params[:id])
    end

    def location_params
      params.require(:location).permit(:city_id, :city, :state, :country, :lat, :lon)
    end
end
