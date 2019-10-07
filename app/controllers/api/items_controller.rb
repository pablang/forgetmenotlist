# Api module
module Api
  # Items controller class
  class ItemsController < ApplicationController
    rescue_from ActionController::ParameterMissing, with: :missing_params
    def index
      @items = Item.all
      render json: @items, status: :ok
    end

    def create
      @item = Item.new(post_params)
      respond_to do |format|
        if @item.save
          format.js
          format.json { render json: @item, status: :created }
        else
          format.json { render json: @item.errors, status: :bad_request }
        end
      end
    end

    def update
      @item = Item.find(params[:id])
      @item.update(put_params)
      respond_to do |format|
        format.js
        format.json { render json: @item, status: :ok }
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.to_s }, status: :not_found
    end

    def destroy
      @item = Item.find(params[:id])
      @item.destroy
      respond_to do |format|
        format.js {}
      end
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

    def missing_params(exception)
      render json: { error: exception.to_s }, status: :unprocessable_entity
    end
  end
end
