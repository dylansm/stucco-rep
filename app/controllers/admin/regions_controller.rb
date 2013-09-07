class Admin::RegionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_only!
  respond_to :html, :json

  def index
  end

end
