class HomeController < ApplicationController
  before_action :find_user, only: [:show, :destroy]

  def destroy
    @user.destroy
    session[:user_id] = nil
    flash[:success] = "Your account was deleted successfully"
    redirect_to root_path
  end  

  private
  def find_user
    @user = User.find(params[:id])
  end 
end
