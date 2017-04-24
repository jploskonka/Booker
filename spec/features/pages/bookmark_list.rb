module Pages
  class BookmarkList
    include Capybara::DSL

    PATH           = '/bookmarks'
    LIST_EL        = '.bookmark-list'
    ITEM_EL      = '.bookmark-list__item'
    ITEM_EDIT_LINK = '.bookmark-list__edit'

    def open
      visit(PATH)
    end

    def click_edit_link(bookmark)
      within(LIST_EL) do
        find(ITEM_EL, text: bookmark.title).find(ITEM_EDIT_LINK).click
      end
    end

    def open?
      page.has_current_path?(PATH)
    end

    def has_bookmark?(bookmark)
      within(LIST_EL) do
        page.has_link?(bookmark.title)
      end
    end

    def has_site_heading?(content)
      within(LIST_EL) do
        page.has_content?(content)
      end
    end
  end
end
