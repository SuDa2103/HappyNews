class LinksController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  def index
    @links = Link.all
  end

  def show
    @link = Link.find(params[:id])
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    @link.user = current_user
    # IF LOGIC WHEN WE HAVE VIEWS
    if @link.save
      redirect_to @link
    else
      render :new
    end
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    @link.update(link_params)
    # IF LOGIC WHEN WE HAVE VIEWS
    if @link.save
      redirect_to @link
    else
      render :new
    end
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    redirect_to root_path
  end

  def link_params
    params.require(:link).permit(:title, :url, :description)
  end
end
