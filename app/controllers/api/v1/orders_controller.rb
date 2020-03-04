include Response

class Api::V1::OrdersController < ApplicationController
  before_action :set_api_v1_order, only: [:show, :update, :destroy]

  # GET /api/v1/orders
  # GET /api/v1/orders.json
  def index
    @api_v1_orders = Order.all
    json_response(@api_v1_orders)
  end

  # GET /api/v1/orders/1
  # GET /api/v1/orders/1.json
  def show
    json_response(@api_v1_order)
  end

  # POST /api/v1/orders
  # POST /api/v1/orders.json
  def create
    begin
      @api_v1_order = Order.new(api_v1_order_params)
      json_response @api_v1_order, :created
    rescue => ex
      json_response({error: ex.message}, :unprocessable_entity)
    end
  end

  # PATCH/PUT /api/v1/orders/1
  # PATCH/PUT /api/v1/orders/1.json
  def update
    begin
      @api_v1_order.update!(api_v1_order_params)
      head :no_content
    rescue => ex
      json_response({error: ex.message}, :unprocessable_entity)
    end
  end

  # DELETE /api/v1/orders/1
  # DELETE /api/v1/orders/1.json
  def destroy
    begin
      @api_v1_order.destroy!
      head :no_content
    rescue => ex
      json_response({error: ex.message}, :unprocessable_entity)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_order
      begin
        @api_v1_order = Order.find(params[:id])
      rescue => ex
        json_response({error: ex.message}, :not_found)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_v1_order_params
      params.fetch(:api_v1_order, {})
    end
end
