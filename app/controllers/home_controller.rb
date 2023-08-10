class HomeController < ApplicationController
  def index
  end  
  def show
  end  

    def destroy
    @user=User.find(params[:id])
    @user.destroy
    session[:user_id]=nil
    flash[:success] = "Your account was deleted successfully"
    redirect_to root_path
  end  
  
end