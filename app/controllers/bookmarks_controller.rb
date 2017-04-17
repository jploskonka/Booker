class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.all
    @new_bookmark = Bookmark.new
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def create
    Bookmark.create!(bookmark_params)

    redirect_to root_url
  end

  def update
    Bookmark.find(params[:id]).update!(bookmark_params)

    redirect_to root_url
  end

  def destroy
    Bookmark.find(params[:id]).destroy!

    redirect_to root_url
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:url, :title)
  end
end
