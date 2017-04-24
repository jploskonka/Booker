class BookmarksController < ApplicationController
  before_action do
    @bookmarks = Bookmark.all
    @sites = Site.all
  end

  def index
    @new_bookmark = Bookmark.new
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def create
    @new_bookmark = Bookmark.new(bookmark_params)

    if @new_bookmark.save
      redirect_to root_url
    else
      render :index
    end
  end

  def update
    @bookmark = Bookmark.find(params[:id])

    if @bookmark.update(bookmark_params)
      redirect_to root_url
    else
      render :edit
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:url, :title)
  end
end
