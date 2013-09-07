class Admin::AdobeProductsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_only!

  respond_to :html, :json

  def index
    user
    @delete_confirm = t("links.dashboard.manage_adobe_products.delete-confirm")
    @adobe_products = AdobeProduct.order("name ASC").page(params[:page])
  end

  #def show
    #user
    #adobe_product
  #end

  # get
  def edit
    user
    adobe_product
  end

  #put
  def update
    if adobe_product.update_attributes(permitted_params)
      redirect_to admin_adobe_products_path
    else
      respond_with adobe_product
    end
    
  end

  # get
  def new
    user
    @adobe_product = AdobeProduct.new
  end

  # post
  def create
    @adobe_product = AdobeProduct.new(permitted_params)

    if @adobe_product.save
      redirect_to admin_adobe_products_path
    else
      respond_with @adobe_product
    end
  end
  
  # delete
  def destroy
    adobe_product.destroy
    #respond_with(:admin, adobe_product)
    render json: { deleted: true }
  end

  private

  def permitted_params
    params.require(:adobe_product).permit(
      :name,
      :mnemonic
    )
  end

  def adobe_product
    @adobe_product ||= AdobeProduct.find(params[:id])
  end

  def user
    @user = current_user
  end

end
