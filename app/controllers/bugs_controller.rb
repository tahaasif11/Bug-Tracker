class BugsController < ApplicationController

  def index

  end  

  def show
    @bug = Bug.find(params[:id])
  end
 
  def new
    @bug = Bug.new
    @project = Project.find(params[:project_id])
  end

  
  def create
 
    @project = Project.find(params[:project_id])
    @bug = @project.bugs.new(bugs_params)
    @current_user=User.find(current_user.id)
    @bug.status="new"
    @bug.creator = current_user

    if @bug.save

      flash[:success] = "bug was created successfully"
      redirect_to projects_path()
    else
    
      flash[:danger] = "bug was not created"
     render :new, status: :unprocessable_entity
    end
  end

  def edit
    @bug = Bug.find(params[:id])
  end

  def update
    @bug = Bug.find(params[:id])
    if @bug.update(bugs_params)
      flash[:success] = "bug was updated successfully"
      redirect_to projects_path()

    else
      flash[:danger] = "bug was not updated"
      render :edit, status: :unprocessable_entity
    end  

  end  

  def destroy
    @bug = Bug.find(params[:id])
    @bug.destroy
    flash[:success] = "bug was deleted successfully"
    redirect_to projects_path()
  end  
  
  private
  
  def bugs_params
    params.require(:bug).permit(:title,:description,:typee,:status,:deadline,:solver_id)
  end


end  