class LinksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :newest]
  def index
    @links = Link.hottest
  end

  def newest
    @links = Link.newest
  end

  def myposts
    @links = []
    @all_links = Link.all
    @all_links.each do |link|
      if link.user == current_user
        @links.push(link)
      end
    end
  end

  def upvoted
    @votes = Vote.where(user_id: current_user.id)
    @links = []
    @votes.each do |vote|
      id = vote.link_id
      link = Link.find(id)
      @links.push(link)
    end
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
    @link = Link.find(params[:id])
    if current_user.owns_link?(@link)
      @link.destroy
      redirect_to root_path, notice: 'Link successfully deleted'
    else
      redirect_to root_path, notice: 'Not authorized to delete this link'
    end
  end

  def upvote
    link = Link.find_by(id: params[:id])
    if current_user.upvoted?(link)
      current_user.remove_vote(link)
    else
      current_user.upvote(link)
    end
    link.calc_hot_score
    redirect_to root_path
  end

  def link_params
    params.require(:link).permit(:title, :url, :description)
  end
end
