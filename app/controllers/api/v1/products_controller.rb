module Api
  module V1
    class ProductsController < ApplicationController
      before_action :set_product, only: [:show, :update, :destroy]
      include HTTParty

      #Get products
      def index
        response = HTTParty.get('https://fakestoreapi.com/products')
        render json: response.parsed_response
      end

      def fetch_and_save
        response = HTTParty.get('https://fakestoreapi.com/products')
        products = response.parsed_response

        products.each do |product_data|
          Product.find_or_create_by(
            name: product_data['name'],
            description: product_data['description'],
            price: product_data['price'],
            image_url: product_data['image_url']
          )
        end
        render json: { message: 'products fetched and saved successfully' }, status: :ok
      end

      def show
      end

      def create
        @product = Product.new(product_params)

        if @product.save
          render json: @product, status: :created
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      end

      def update
        if @product.update(product_params)
          render json: @product
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @product.destroy
      end

      private

      def set_product
        @product = Product.find(params[:id])
      end

      def product_params
        params.require(:product).permit(:name, :description, :price, :image_url)
      end
    end
  end
end
