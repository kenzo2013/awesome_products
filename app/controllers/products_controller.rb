class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new]
  before_action :set_product, only: [:show]
  def index
    @products = Product.includes(:attachments)
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product[:user_id] = current_user.id
    respond_to do |format|
      if @product.save
        format.html { redirect_to products_path, notice: 'Product was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  private

  def set_product
    @product = Product.find_by(id: params[:id])
  end
  def product_params
    params.require(:product).permit(:name, :description, files: [])
  end
end
