# Api module
module Api
  # Items controller class
  class ItemsController < ApplicationController
    def index
      @items = Item.all
      render json: @items, status: :ok
    end

    def create
      @item = Item.new(post_params)
      respond_to do |format|
        if @item.save
          format.json { render json: @item, status: :created }
        else
          format.json { render json: @item.errors, status: :bad_request }
        end
      end
    rescue ActionController::ParameterMissing => e
      render json: { error: e.to_s }, status: :unprocessable_entity
    end

    def update
      @item = Item.find(params[:id])
      @item.update(put_params)
      render json: @item, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.to_s }, status: :not_found
    rescue ActionController::ParameterMissing => e
      render json: { error: e.to_s }, status: :unprocessable_entity
    end

    def destroy
      @item = Item.find(params[:id])
      @item.destroy
      # TODO: research how to avoid repeating this
    rescue ActiveRecord::RecordNotFound
      head :no_content
    end

    private

    def post_params
      params.require(:item).permit(:text, :checked)
    end

    def put_params
      params.require(:item).permit(:checked)
    end
  end
end
