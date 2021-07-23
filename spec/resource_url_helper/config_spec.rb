describe ResourceUrlHelper::Config do
  context 'configure' do
    before do
      ResourceUrlHelper.configure do |config|
        config.url_helpers = true
      end
    end

    after do
      ResourceUrlHelper.configure do |config|
        config.url_helpers = nil
      end
    end

    it 'gets and sets' do
      expect(ResourceUrlHelper.config.url_helpers).to eq(true)
    end
  end
end
