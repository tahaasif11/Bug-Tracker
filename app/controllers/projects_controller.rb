class ProjectsController < ApplicationController
  before_action :find_project, only: [:show, :edit, :destroy, :update]
  
  def index
    if current_user.typee=="developer" or current_user.typee=="qa"
      @projects = current_user.projects
    else  
      @projects = current_user.created_projects
    end  
  end

  def edit
    authorize! :edit, @project
  end  

  def show
    @project_users = @project.project_users
    @bug = Bug.new
  end

  def new
    @project = Project.new
    authorize! :create, @project
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

  def update
    if @project.update(params_project)
      flash[:success] = "project was updated successfully!"
      redirect_to projects_path()
    else
      flash[:success] = "project was not updated!"
      render :edit, status: 422
    end  
  end  

  def destroy
    @project.destroy
    flash[:success] = "project was deleted successfully!"
    redirect_to projects_path()
  end  

  private
  def params_project
    params.require(:project).permit(:name, :description, user_ids:[])
  end

  def find_project
    @project = Project.find(params[:id])
  end  
end  