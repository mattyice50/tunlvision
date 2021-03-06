class VideosController < ApplicationController
  before_action :find_project

  def index

  end


  def show


  end


  def new
    @video = @project.videos.new
  end


  def create
    user_id = current_user.id
    @video = @project.videos.new create_params
    @video.user_id = user_id
    if @video.save!
      redirect_to @project, :flash => {:success => "You have successfully added a video to #{@project.title}"}
    else
      redirect_to :back, :flash => {:failure => "Something went wrong :("}
    end
  end


  def edit
    @video = @project.videos.find params[:id]
  end


  def update
    @video = @project.videos.find params[:id]
    @video.update_attributes create_params
    if @video.save!
      redirect_to @project, :flash => {:success => "You have successfully updated the video!"}
    else
      redirect_to :back
    end
  end


  def destroy
    @video = @project.videos.find params[:id]
    if @video.destroy!
      redirect_to @project, :flash => {:success => "The video was successfully removed!"}
    else
      redirect_to :back, :flash => {:failure => "Something went wrong."}
    end

  end

  private


  def find_project
    @project = current_user.collaborations.find(params[:project_id])
    rescue
    @project = current_user.projects.find(params[:project_id])
  end


  def create_params
    params.require(:video).permit(:title, :url, :description)
  end



end
