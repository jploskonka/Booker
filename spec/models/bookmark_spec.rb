require 'rails_helper'

describe Bookmark do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:url) }

    describe 'url validation' do
      context 'with incorrect url' do
        subject { build(:bookmark, url: 'this-is-not-url') }

        it { is_expected.to be_invalid }
      end

      context 'with correct url' do
        subject { build(:bookmark) }

        it { is_expected.to be_valid }
      end
    end
  end
end
