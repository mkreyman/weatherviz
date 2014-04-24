class WeatherReportsController < ApplicationController
  before_action :set_weather_report, only: [:show, :edit, :update, :destroy]

  def index
    @weather_reports = WeatherReport.order(time_received: :desc)
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
    if (current_user.present? && current_user.admin?)
      @weather_report.destroy
      redirect_to weather_reports_url, notice: 'Report was deleted.'
    else
      redirect_to weather_reports_path, alert: 'Not authorized.'
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
