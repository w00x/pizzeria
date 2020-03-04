include Response

class Api::V1::StoresController < ApplicationController
  before_action :set_api_v1_store, only: [:show, :update, :destroy, :add_products, :delete_products]

  # GET /api/v1/stores
  # GET /api/v1/stores.json
  def index
    @api_v1_stores = Store.all
    json_response(@api_v1_stores)
  end

  # GET /api/v1/stores/1
  # GET /api/v1/stores/1.json
  def show
    json_response(@api_v1_store)
  end

  # POST /api/v1/stores
  # POST /api/v1/stores.json
  def create
    begin
      @api_v1_store = Store.create!(api_v1_store_params)

      json_response @api_v1_store, :created
    rescue => ex
      json_response({error: ex.message}, :unprocessable_entity)
    end
  end

  # PATCH/PUT /api/v1/stores/1
  # PATCH/PUT /api/v1/stores/1.json
  def update
    begin
      @api_v1_store.update!(api_v1_store_params)
      head :no_content
    rescue => ex
      json_response({error: ex.message}, :unprocessable_entity)
    end
  end

  # DELETE /api/v1/stores/1
  # DELETE /api/v1/stores/1.json
  def destroy
    begin
      @api_v1_store.destroy!
      head :no_content
    rescue => ex
      json_response({error: ex.message}, :unprocessable_entity)
    end
  end

  def add_products
    ActiveRecord::Base.transaction do
      begin
        if params[:product_ids].present?
          params[:product_ids].each do |product_id|
            @api_v1_store.products << Product.find(product_id)
          end
          @api_v1_store.reload
        end

        json_response @api_v1_store, :created
      rescue => ex
        json_response({error: ex.message}, :unprocessable_entity)
        raise ActiveRecord::Rollback
      end
    end
  end

  def delete_products
    ActiveRecord::Base.transaction do
      begin
        if params[:product_ids].present?
          params[:product_ids].each do |product_id|
            @api_v1_store.products.delete(Product.find(product_id))
          end
          @api_v1_store.reload
        end

        json_response @api_v1_store, :ok
      rescue => ex
        json_response({error: ex.message}, :unprocessable_entity)
        raise ActiveRecord::Rollback
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_store
      begin
        @api_v1_store = Store.find(params[:id])
      rescue => ex
        json_response({error: ex.message}, :not_found)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_v1_store_params
      params.permit(:name, :address, :email, :phone)
    end
end
