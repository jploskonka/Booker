module Pages
  class NewBookmarkForm
    include Capybara::DSL

    def open
      within '.bookmark-list__heading' do
        click_button 'Add'
      end
    end

    def submit(title:, url:, shortening: '')
      within el do
        fill_in 'bookmark_title', with: title
        fill_in 'bookmark_url', with: url
        fill_in 'bookmark_shortening', with: shortening

        click_button 'Create Bookmark'
      end
    end

    def visible?
      el.visible?
    end

    private

    def el
      find('.bookmark-form--new', visible: false)
    end
  end
end
