require 'rails_helper'
require_relative 'shared/url_format_validation_spec'

describe Site do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:url) }

    include_examples 'url format validation', :site
  end
end
