class BookmarksController < ApplicationController
  before_action do
    # TODO: Facade, better way to build SQL query
    # NOTE: Check up against sql injection
    query = params[:search] ? params[:search][:query] : nil
    @bookmarks = BookmarkFilterer.new(query).call
    @sites = Site.where(id: @bookmarks.pluck(:site_id))
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
