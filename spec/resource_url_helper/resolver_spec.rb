describe ResourceUrlHelper::Resolver do
  context 'attribute' do
    let(:comment) { Comment.find(1) }

    it 'resolves url path' do
      url = described_class.new(comment, only_path: true).call
      expect(url).to eq("/items/#{comment.item_id}/comments/#{comment.id}")
    end

    it 'resolves url path for edit' do
      url = described_class.new(comment, action: :edit, only_path: true).call
      expect(url).to eq("/items/#{comment.item_id}/comments/#{comment.id}/edit")
    end

    it 'resolves url' do
      url = described_class.new(comment, host: 'http://example.com').call
      expect(url).to eq("http://example.com/items/#{comment.item_id}/comments/#{comment.id}")
    end

    it 'resolves url for edit' do
      url = described_class.new(comment, action: :edit, host: 'http://example.com').call
      expect(url).to eq("http://example.com/items/#{comment.item_id}/comments/#{comment.id}/edit")
    end
  end

  context 'association' do
    let(:comment) { Association::Comment.find(1) }

    it 'resolves url' do
      url = described_class.new(comment, only_path: true).call
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
      url = described_class.new(comment, only_path: true).call
      expect(url).to eq("/items/0/comments/#{comment.id}")
    end
  end
end
