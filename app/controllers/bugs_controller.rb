class BugsController < ApplicationController
  before_action :find_bug, only: [:show, :edit, :update, :destroy]
  before_action :find_project, only: [:new, :create]

  def show
    authorize! :read, @bug
  end  
 
  def new
    @bug = Bug.new
    authorize! :create, @bug
  end

  def edit
    authorize! :edit, @bug
  end  

  def create
    @bug = @project.bugs.new(bugs_params)
    @bug.creator = current_user
    if @bug.save
      flash[:success] = "bug was created successfully"
      redirect_to project_path(@project)
    else
      flash[:danger] = "bug was not created"
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @bug.update(bugs_params)
      flash[:success] = "bug was updated successfully"
      redirect_to project_path(@bug.project)
    else
      flash[:danger] = "bug was not updated"
      render :edit, status: :unprocessable_entity
    end  
  end  

  def destroy
    @project=@bug.project
    authorize! :destroy, @bug
    @bug.destroy
    flash[:success] = "bug was deleted successfully"
    redirect_to project_path(@project)
  end  
  
  private
  def bugs_params
    params.require(:bug).permit(:title, :description, :typee, 
    :status, :deadline, :solver_id, :image)
  end

  def find_bug
    @bug = Bug.find(params[:id])
  end  

  def find_project
    @project = Project.find(params[:project_id])
  end  
end   