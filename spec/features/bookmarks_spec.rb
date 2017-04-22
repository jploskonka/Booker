require 'rails_helper'

require_relative 'pages/bookmark_list'
require_relative 'pages/new_bookmark_form'

feature 'Bookmark list' do
  let!(:bookmark) { create(:bookmark) }
  let(:page)      { Pages::BookmarkList.new }
  let(:form_new)  { Pages::NewBookmarkForm.new }

  scenario 'User adds new bookmark', js: true do
    page.open
    form_new.open
    form_new.submit(
      title: 'Some title',
      url: 'http://example.com/foobar'
    )

    expect(page).to be_open
    expect(form_new).not_to be_visible
    expect(page).to have_bookmark(title: 'Some title')
  end

  scenario 'User creates bookmark with empty form', js: true do
    page.open
    form_new.open
    form_new.submit

    expect(page).to be_open
    expect(form_new).to be_visible
  end

  xscenario 'User visits bookmarks list' do
    visit '/'

    within '.bookmark-list' do
      expect(page).to have_content(bookmark.title)
    end
  end

  xscenario 'User adds bookmark' do
    visit '/'

    within '#bookmark-new-form' do
      fill_in 'bookmark_title', with: 'Some title'
      fill_in 'bookmark_url', with: 'http://example.com'
      fill_in 'bookmark_shortening', with: 'st'

      click_button 'OK'
    end

    expect(page).to have_current_path('/')

    within '#bookmark-list' do
      expect(page).to have_content(bookmark.title)
      expect(page).to have_content('Some title')
    end
  end

  xscenario 'User removes bookmark' do
    visit '/'

    within '#bookmark-list' do
      click_link('delete')
    end

    expect(page).to have_current_path('/')
    expect(page).not_to have_content(bookmark.title)
  end

  xscenario 'User edits bookmark' do
    visit '/'

    within '#bookmark-list' do
      click_link('edit')
    end

    expect(page).to have_current_path("/bookmarks/#{bookmark.id}/edit")

    within '#bookmark-edit-form' do
      fill_in 'bookmark_title', with: 'new title'
      click_button 'OK'
    end

    expect(page).to have_current_path('/')

    within '#bookmark-list' do
      expect(page).not_to have_content(bookmark.title)
      expect(page).to have_content('new title')
    end
  end
end
