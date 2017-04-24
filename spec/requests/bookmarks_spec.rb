require 'rails_helper'

describe 'Bookmarks' do
  describe 'GET /' do
    let!(:bookmarks) { FactoryGirl.create_list(:bookmark, 2) }

    it 'renders list of bookmarks' do
      get '/'

      expect(response).to redirect_to('/bookmarks')
      follow_redirect!
      expect(response.body).to include(*bookmarks.map(&:title))
    end
  end

  describe 'PUT /bookmarks/:id' do
    let!(:bookmark) { create(:bookmark) }

    context 'when params are correct' do
      let(:params) do
        { bookmark: attributes_for(:bookmark) }
      end

      it 'updates bookmark' do
        expect {
          put "/bookmarks/#{bookmark.id}", params: params
        }.to change {
          Bookmark.find(bookmark.id).title
        }.from(bookmark.title).to(params[:bookmark][:title])

        expect(response).to redirect_to('/')
      end
    end
  end
end
