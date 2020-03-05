include Response

class Api::V1::OrdersController < ApplicationController
  before_action :set_api_v1_order, only: [:show, :update, :destroy]

  # GET /api/v1/orders
  # GET /api/v1/orders.json
  def index
    @api_v1_orders = Order.all
    json_response(@api_v1_orders.map {|o| o.as_json(methods: [:total, :products]) })
  end

  # GET /api/v1/orders/1
  # GET /api/v1/orders/1.json
  def show
    json_response(@api_v1_order.as_json(methods: [:total, :products]))
  end

  # POST /api/v1/orders
  # POST /api/v1/orders.json
  def create
    ActiveRecord::Base.transaction do
      begin
        @api_v1_order = Order.create!(api_v1_order_params)

        params[:products_id].each do |product_id|
          @api_v1_order.products << Product.find(product_id)
        end

        Api::V1::OrderMailer.new_order(@api_v1_order).deliver_now

        json_response @api_v1_order.as_json(methods: [:total, :products]), :created
      rescue => ex
        json_response({error: ex.message}, :unprocessable_entity)
        raise ActiveRecord::Rollback
      end
    end
  end

  # PATCH/PUT /api/v1/orders/1
  # PATCH/PUT /api/v1/orders/1.json
  def update
    ActiveRecord::Base.transaction do
      begin
        @api_v1_order.update!(api_v1_order_params)

        @api_v1_order.products.destroy_all
        
        params[:products_id].each do |product_id|
          @api_v1_order.products << Product.find(product_id)
        end

        head :no_content
      rescue => ex
        json_response({error: ex.message}, :unprocessable_entity)
        raise ActiveRecord::Rollback
      end
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
      params.permit(:store_id)
    end
end
