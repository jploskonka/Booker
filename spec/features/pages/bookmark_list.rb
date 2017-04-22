module Pages
  class BookmarkList
    include Capybara::DSL
    PATH = '/'

    def open
      visit PATH
    end

    def open?
      page.has_current_path? PATH
    end

    def has_bookmark?(title:)
      within '.bookmark-list' do
        page.has_link? title
      end
    end
  end
end
