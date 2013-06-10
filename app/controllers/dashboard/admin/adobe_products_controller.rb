class Dashboard::Admin::AdobeProductsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @adobe_products = AdobeProduct.order("name ASC").page(params[:page])
  end

  def show
    @adobe_product = AdobeProduct.find(params[:id])
  end

  # get
  def edit
    @adobe_product = AdobeProduct.find(params[:id])
  end

  #put
  def update
    @adobe_product = AdobeProduct.find(params[:id])
    if @adobe_product.update_attributes(permitted_params)
      redirect_to dashboard_manage_adobe_products_path
    else
      render "/dashboard/admin/adobe_products/#{params[:id]}/edit"
    end
    
  end

  # get
  def new
  end

  # post
  def create
  end
  
  # delete
  def destroy
  end

  private

  def permitted_params
    params.require(:adobe_product).permit(
      :name,
      :mnemonic
    )
  end

end
