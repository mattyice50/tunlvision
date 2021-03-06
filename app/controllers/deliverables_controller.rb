class DeliverablesController < ApplicationController
  before_action :find_project, except: [:index]

  def show
    @deliverable = @project.deliverables.find params[:id]
  end

  def index

  end

  def new
    @deliverable = @project.deliverables.new
  end


  def create
    @deliverable = @project.deliverables.new create_params
    if @deliverable.save
      redirect_to [@project, @deliverable], :flash => {:success => "Created new deliverable for #{@project.title}!"}
    else
      redirect_to :back, :flash => {:failure => "Something went wrong :("}
    end
  end


  def edit
    @deliverable = @project.deliverables.find params[:id]
  end

  def update
    @deliverable = @project.deliverables.find params[:id]
    if @deliverable.update_attributes create_params
      redirect_to [@project, @deliverable], :flash => {:success => "Deliverable was Successfully updated!"}
    else
      redirect_to :back, :flash => {:failure => "Something went wrong :("}
    end
  end

  def destroy
    @deliverable = @project.deliverables.find params[:id]
    if @deliverable.destroy!
      redirect_to @project, :flash => {:success => "You have successfully deleted"}
    else
      redirect_to :back, :flash => {:failure => "Something went wrong."}
    end
  end


  private

  def create_params
    params.require(:deliverable).permit(:title, :description, :timebox)
  end

  def find_project
    @project = current_user.collaborations.find(params[:project_id])
    rescue
    @project = current_user.projects.find(params[:project_id])
  end

end
