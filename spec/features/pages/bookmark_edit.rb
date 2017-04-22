module Pages
  class BookmarkEdit < Struct.new(:bookmark)
    include Capybara::DSL

    def open?
      page.has_current_path?(path)
    end

    # Note:
    # It's pretty similar to submit method of `NewBookmarkForm`
    # class, leaving it as duplication because DRYing it up
    # introduces more complexity than helps in anything.
    # Probably good idea to extract it to separate page fragment
    # like `BookmarkForm` when more common behaviour is discovered
    def submit(title: '', url: '', shortening: '')
      fill_in 'bookmark_title',      with: title
      fill_in 'bookmark_url',        with: url
      fill_in 'bookmark_shortening', with: shortening

      click_button 'Update Bookmark'
    end

    private

    def path
      "/bookmarks/#{bookmark.id}/edit"
    end
  end
end
