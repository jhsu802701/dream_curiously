#
class UsersController < ApplicationController
  before_filter :admin_signed_in?, only: [:index, :show]
  before_filter :admin_or_correct_user, only: [:show]

  def show
    redirect_to(root_path) unless admin_or_correct_user
    @user = User.find(params[:id])
  end

  def new
  end

  def index
    redirect_to(root_path) unless admin_signed_in?
    @search = User.search(params[:q])
    @users = @search.result.paginate(page: params[:page])
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?
  end

  def destroy
    if admin_signed_in?
      User.find(params[:id]).destroy
      flash[:success] = 'User deleted'
      redirect_to(users_path)
    else
      redirect_to(root_path)
    end
  end

  def admin_or_correct_user
    current_user == User.find(params[:id]) || admin_signed_in?
  end
end
