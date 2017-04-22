require 'rails_helper'

require_relative 'pages/bookmark_list'
require_relative 'pages/new_bookmark_form'

feature 'Bookmark list', js: true do
  let!(:bookmark)    { create(:bookmark) }

  let(:new_bookmark) { build(:bookmark)}
  let(:page)         { Pages::BookmarkList.new }
  let(:form_new)     { Pages::NewBookmarkForm.new }

  scenario 'User visits bookmarks list' do
    page.open

    expect(page).to have_bookmark(bookmark)
    expect(form_new).not_to be_visible
  end

  scenario 'User creates bookmark with correct data' do
    page.open

    form_new.open
    form_new.submit(
      title: new_bookmark.title,
      url: new_bookmark.url
    )

    expect(page).to be_open
    expect(page).to have_bookmark(new_bookmark)
    expect(form_new).not_to be_visible
  end

  scenario 'User creates bookmark with empty form' do
    page.open
    form_new.open
    form_new.submit

    expect(page).to be_open
    expect(form_new).to be_visible
    expect(form_new).to have_error_message('title', "can't be blank")
    expect(form_new).to have_error_message('url', "can't be blank")
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
