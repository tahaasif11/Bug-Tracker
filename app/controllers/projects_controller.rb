class ProjectsController < ApplicationController
  
  def index

    if current_user.typee=="developer" or current_user.typee=="qa"

      @project =current_user.project_users.pluck(:project_id)
      @projects = Project.find(@project)

    else  
      @projects = current_user.projects
    end  
    

  end

  def show
    @project = Project.find(params[:id])
    @project_users = @project.project_users
  end

  def new
    @project = Project.new

  end  


  def create
    @project = Project.new(params_project)
    @project.manager=current_user
    if @project.save
      flash[:success] = "project was created successfully!"
      redirect_to projects_path()
    else
      flash[:success] = "project was not created!"
      render :new, status: 422
    end

  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(params_project)
      flash[:success] = "project was updated successfully!"
      redirect_to projects_path()

    else
      flash[:success] = "project was not updated!"
      render :edit, status: 422
    end  

  end  

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:success] = "project was deleted successfully!"
    redirect_to projects_path()
  end  

  private
  def params_project
    params.require(:project).permit(:name,:description, user_ids:[])
  end

end  