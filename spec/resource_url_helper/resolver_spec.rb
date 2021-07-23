describe ResourceUrlHelper::Resolver do
  let(:url_helpers) { Rails.application.routes.url_helpers }

  context 'attribute' do
    let(:comment) { Comment.find(1) }

    it 'resolves url path' do
      url = url_helpers.resource_url_for(comment, only_path: true)
      expect(url).to eq("/items/#{comment.item_id}/comments/#{comment.id}")
    end

    it 'resolves url path for edit' do
      url = url_helpers.resource_url_for(comment, action: :edit, only_path: true)
      expect(url).to eq("/items/#{comment.item_id}/comments/#{comment.id}/edit")
    end

    it 'resolves url' do
      url = url_helpers.resource_url_for(comment, host: 'http://example.com')
      expect(url).to eq("http://example.com/items/#{comment.item_id}/comments/#{comment.id}")
    end

    it 'resolves url for edit' do
      url = url_helpers.resource_url_for(comment, action: :edit, host: 'http://example.com')
      expect(url).to eq("http://example.com/items/#{comment.item_id}/comments/#{comment.id}/edit")
    end
  end

  context 'association' do
    let(:comment) { Association::Comment.find(1) }

    it 'resolves url' do
      url = url_helpers.resource_url_for(comment, only_path: true)
      expect(url).to eq("/items/#{comment.item.id}/comments/#{comment.id}")
    end
  end

  context 'blank association' do
    let(:comment) { Association::Comment.find(1) }

    around do |example|
      ActiveRecord::Base.transaction do
        comment.item.destroy
        comment.item = nil
        example.run
        raise ActiveRecord::Rollback.new
      end
    end

    it 'resolves url' do
      url = url_helpers.resource_url_for(comment, only_path: true)
      expect(url).to eq("/items/0/comments/#{comment.id}")
    end
  end
end
