class WeatherReportsController < ApplicationController
  before_action :set_weather_report, only: [:show, :edit, :update, :destroy]

  def index
    if params[:search]
      WeatherFetcher.fetch(params[:search])
      sanitized_search = params[:search].split(/[\s,]+/).first.strip
      # @weather_reports = WeatherReport.search(params[:search]).order(time_received: :desc)
      @weather_reports = WeatherReport.search(sanitized_search).order(time_received: :desc)
    else
      @weather_reports = WeatherReport.order(time_received: :desc)
    end
  end

  def show
  end

  def new
    @weather_report = WeatherReport.new
  end

  def edit
  end

  def create
    @weather_report = WeatherReport.new(weather_report_params)

    respond_to do |format|
      if @weather_report.save
        format.html { redirect_to @weather_report, notice: 'Weather report was successfully created.' }
        format.json { render action: 'show', status: :created, location: @weather_report }
      else
        format.html { render action: 'new' }
        format.json { render json: @weather_report.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @weather_report.update(weather_report_params)
        format.html { redirect_to @weather_report, notice: 'Weather report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @weather_report.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @weather_report.destroy
    respond_to do |format|
      format.html { redirect_to weather_reports_url }
      format.json { head :no_content }
    end
  end

  private
    def set_weather_report
      @weather_report = WeatherReport.find(params[:id])
    end

    def weather_report_params
      params.require(:weather_report).permit(
          :location_id, :time_received, :sunrise, :sunset,
          :weather, :weather_desc, :temp, :temp_min, :temp_max,
          :pressure, :humidity, :wind_speed, :wind_gust, :wind_degree,
          :clouds, :rain_3h, :snow_3h)
    end
end
