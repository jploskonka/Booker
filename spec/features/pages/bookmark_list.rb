module Pages
  class BookmarkList
    include Capybara::DSL
    PATH = '/bookmarks'

    def open
      visit PATH
    end

    def open?
      page.has_current_path? PATH
    end

    def has_bookmark?(bookmark)
      within '.bookmark-list' do
        page.has_link? bookmark.title
      end
    end
  end
end
