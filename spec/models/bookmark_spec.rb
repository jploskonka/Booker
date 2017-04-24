require 'rails_helper'
require_relative 'shared/url_format_validation_spec'

describe Bookmark do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:url) }

    include_examples 'url format validation', :bookmark
  end

  it { is_expected.to belong_to(:site) }
end
