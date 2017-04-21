require 'rails_helper'

describe ApplicationHelper do
  describe '#body_html_class' do
    subject { helper.body_html_class }

    context 'when params include css-debug=please' do
      before { controller.params['css-debug'] = 'please' }

      it { is_expected.to eq('css-debug') }
    end

    context 'when params is empty' do
      it { is_expected.to eq('') }
    end
  end
end
