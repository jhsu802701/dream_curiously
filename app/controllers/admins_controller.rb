#
class AdminsController < ApplicationController
  before_filter :admin_signed_in?, only: [:index, :show]

  def show
    redirect_to(root_path) unless admin_signed_in?
    @admin = Admin.find(params[:id])
  end

  def index
    redirect_to(root_path) unless admin_signed_in?
    @admins = Admin.paginate(page: params[:page])
  end
end
