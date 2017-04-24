shared_examples 'url format validation' do |factory|
  context 'with incorrect url' do
    subject { build(factory, url: 'this-is-not-url') }

    it { is_expected.to be_invalid }
  end

  context 'with correct url' do
    subject { build(factory, url: Faker::Internet.url) }

    it { is_expected.to be_valid }
  end
end
