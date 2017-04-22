class BookmarksController < ApplicationController
  before_action do
    @bookmarks = Bookmark.all
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
      render action: :index
    end
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
