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

  describe 'POST /bookmarks' do
    context 'with correct params' do
      let(:params) do
        { bookmark: attributes_for(:bookmark) }
      end

      it 'creates new bookmark' do
        expect {
          post '/bookmarks', params: params
        }.to change(Bookmark, :count).by(1)

        expect(response).to redirect_to('/')
      end
    end

    context 'with incorrect params' do
      let(:params) do
        { bookmark: attributes_for(:bookmark).except(:title) }
      end

      it 'does not create bookmark' do
        expect {
          post '/bookmarks', params: params
        }.not_to change(Bookmark, :count)

        expect(response).not_to redirect_to('/')
      end
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

  describe 'DELETE /bookmarks/:id' do
    let!(:bookmark) { create(:bookmark) }

    it 'deletes bookmark' do
      expect {
        delete "/bookmarks/#{bookmark.id}"
      }.to change(Bookmark, :count).by(-1)

      expect(response).to redirect_to('/')
    end
  end
end
