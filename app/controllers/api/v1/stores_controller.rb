include Response

class Api::V1::StoresController < ApplicationController
  before_action :set_api_v1_store, only: [:show, :update, :destroy]

  # GET /api/v1/stores
  # GET /api/v1/stores.json
  def index
    @api_v1_stores = Store.all
  end

  # GET /api/v1/stores/1
  # GET /api/v1/stores/1.json
  def show
  end

  # POST /api/v1/stores
  # POST /api/v1/stores.json
  def create
    @api_v1_store = Store.new(api_v1_store_params)

    if @api_v1_store.save
      render :show, status: :created, location: @api_v1_store
    else
      render json: @api_v1_store.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/stores/1
  # PATCH/PUT /api/v1/stores/1.json
  def update
    if @api_v1_store.update(api_v1_store_params)
      render :show, status: :ok, location: @api_v1_store
    else
      render json: @api_v1_store.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/stores/1
  # DELETE /api/v1/stores/1.json
  def destroy
    @api_v1_store.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_store
      @api_v1_store = Store.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_v1_store_params
      params.fetch(:api_v1_store, {})
    end
end
