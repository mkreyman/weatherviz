class RulesController < ApplicationController
  before_action :set_rule, only: [:show, :edit, :update, :destroy]
  before_action :current_user, only: [:read_from_cache]
  before_action :read_from_cache, only: [:index, :new, :create]

  # GET /rules
  # GET /rules.json
  def index
    @rules = @alert.rules
  end

  # GET /rules/1
  # GET /rules/1.json
  def show
  end

  # GET /rules/new
  def new
    @rule = @alert.rules.new
  end

  # GET /rules/1/edit
  def edit
  end

  # POST /rules
  # POST /rules.json
  def create
    @rule = @alert.rules.new(rule_params)
    respond_to do |format|
      if @rule.save
        format.html { redirect_to @rule.alert, notice: 'Rule was successfully created.' }
        format.json { render action: 'show', status: :created, location: @rule }
      else
        format.html { render action: 'new' }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rules/1
  # PATCH/PUT /rules/1.json
  def update
    respond_to do |format|
      if @rule.update(rule_params)
        format.html { redirect_to @rule.alert, notice: 'Rule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rules/1
  # DELETE /rules/1.json
  def destroy
    @rule.destroy
    respond_to do |format|
      format.html { redirect_to @rule.alert }
      format.json { head :no_content }
    end
  end

  def read_from_cache
    @alert = Alert.find(Rails.cache.read(current_user.id)[:alert])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rule
      @rule = Rule.find(params[:id])
    end

    def rule_params
      params.require(:rule).permit(:field, :operator, :value)
    end

end
