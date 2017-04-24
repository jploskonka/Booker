require 'rails_helper'

require_relative 'pages/bookmark_list'
require_relative 'pages/bookmark_edit'
require_relative 'pages/new_bookmark_form'

feature 'Bookmark list', js: true do
  let!(:bookmark)    { create(:bookmark, url: 'http://some-url.com/my/path/is/very-long') }

  let(:new_bookmark) { build(:bookmark)}
  let(:list_page)    { Pages::BookmarkList.new }
  let(:edit_page)    { Pages::BookmarkEdit.new(bookmark) }
  let(:form_new)     { Pages::NewBookmarkForm.new }

  background do
    list_page.open
  end

  scenario 'User visits bookmarks list' do
    expect(list_page).to have_bookmark(bookmark)
    expect(list_page).to have_site_heading('http://some-url.com')
    expect(form_new).not_to be_visible
  end

  scenario 'User creates bookmark with correct data' do
    form_new.open
    form_new.submit(
      title: new_bookmark.title,
      url: new_bookmark.url
    )

    expect(list_page).to be_open
    expect(list_page).to have_bookmark(new_bookmark)
    expect(form_new).not_to be_visible
  end

  scenario 'User creates bookmark with empty form' do
    form_new.open
    form_new.submit

    expect(list_page).to be_open
    expect(form_new).to be_visible
    expect(form_new).to have_error_message('title', "can't be blank")
    expect(form_new).to have_error_message('url', "can't be blank")
  end

  scenario 'User edits bookmark' do
    list_page.click_edit_link(bookmark)
    expect(edit_page).to be_open

    edit_page.submit(
      title: new_bookmark.title,
      url: new_bookmark.url
    )

    expect(list_page).to be_open
    expect(list_page).to have_bookmark(new_bookmark)
    expect(list_page).not_to have_bookmark(bookmark)
  end
end
