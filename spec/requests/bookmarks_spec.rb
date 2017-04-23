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
    subject(:perform_request) { post '/bookmarks', params: params }

    context 'with correct params' do
      let(:domain)         { Faker::Internet.domain_name }
      let(:path)           { Faker::Internet.slug }
      let(:url)            { Faker::Internet.url(domain, "/#{path}") }
      let(:bookmark_attrs) { attributes_for(:bookmark, url: url) }
      let(:bookmark)       { Bookmark.last }

      let(:params) do
        { bookmark: bookmark_attrs }
      end

      context 'when matching Site record does not exist' do
        it 'creates new Bookmark' do
          expect { perform_request }.to change(Bookmark, :count).by(1)
        end

        it 'creates new Site' do
          expect { perform_request }.to change(Site, :count).by(1)
        end

        it 'connects bookmark with site' do
          perform_request

          expect(bookmark.site.url).to eq("http://#{domain}")
        end
      end

      context 'when matching Site already exist' do
        let!(:site) { create(:site, url: "http://#{domain}") }

        it 'creates new Bookmark' do
          expect { perform_request }.to change(Bookmark, :count).by(1)
        end

        it 'does not create new Site' do
          expect { perform_request }.not_to change(Site, :count)
        end

        it 'connects bookmark with site' do
          perform_request

          expect(bookmark.site.id).to eq(site.id)
        end
      end
    end

    context 'with incorrect params' do
      let(:params) do
        { bookmark: attributes_for(:bookmark).except(:title) }
      end

      it 'does not create bookmark' do
        expect { perform_request }.not_to change(Bookmark, :count)
      end

      it 'does not create site' do
        expect { perform_request }.not_to change(Site, :count)
      end

      it 'does not redirect' do
        perform_request

        expect(response).not_to be_redirect
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
