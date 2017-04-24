require 'rails_helper'

require_relative 'pages/bookmark_list'

feature 'Searching bookmarks' do
  let!(:bookmarks) { create_list(:bookmark, 2) }
  let(:list_page)  { Pages::BookmarkList.new }

  background do
    list_page.open
  end

  scenario 'User search for existing bookmark [matching title]' do
    list_page.search(bookmarks[0].title)

    expect(list_page).to have_bookmark(bookmarks[0])
    expect(list_page).not_to have_bookmark(bookmarks[1])
  end

  scenario 'User search for non matching bookmark' do
    list_page.search('There is no bookmark like this one for sure!')

    expect(list_page).to have_bookmark(bookmarks[0])
    expect(list_page).to have_bookmark(bookmarks[1])
  end
end
