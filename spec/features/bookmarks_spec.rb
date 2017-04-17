require 'rails_helper'

feature 'Bookmark list' do
  let!(:bookmark) { create(:bookmark) }

  scenario 'User adds bookmark' do
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

  scenario 'User removes bookmark' do
    visit '/'

    within '#bookmark-list' do
      click_link('delete')
    end

    expect(page).to have_current_path('/')
    expect(page).not_to have_content(bookmark.title)
  end

  scenario 'User edits bookmark' do
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
