class Dashboard::Admin::AdobeProductsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json

  def index
    @delete_confirm = t("links.dashboard.manage_adobe_products.delete-confirm")
    @adobe_products = AdobeProduct.order("name ASC").page(params[:page])
  end

  def show
    adobe_product
  end

  # get
  def edit
    adobe_product
  end

  #put
  def update
    if adobe_product.update_attributes(permitted_params)
      redirect_to dashboard_manage_adobe_products_path
    else
      respond_with adobe_product
    end
    
  end

  # get
  def new
    @adobe_product = AdobeProduct.new
  end

  # post
  def create
    @adobe_product = AdobeProduct.new(permitted_params)

    if @adobe_product.save
      redirect_to dashboard_admin_adobe_products_path
    else
      respond_with @adobe_product
    end
  end
  
  # delete
  def destroy
    adobe_product.destroy
    
    #TODO enable this
    #set_flash_message :notice, :updated

    respond_with adobe_product
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

end
