class LinksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @links = Link.all
  end

  def show
    @link = Link.find(params[:id])
    @comments = @link.comments
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

      if current_user.owns_link?(@link)
        @link
      else
        redirect_to root_path, notice: 'Not authorized to edit this link'
      end
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
    if current_user.owns_link?(link)
      link.destroy
      redirect_to root_path, notice: 'Link successfully deleted'
    else
      redirect_to root_path, notice: 'Not authorized to delete this link'
    end
  end

  def link_params
    params.require(:link).permit(:title, :url, :description)
  end
end
