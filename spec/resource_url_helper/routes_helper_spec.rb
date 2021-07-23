describe ResourceUrlHelper::RoutesHelper do
  let(:url_helpers) { Rails.application.routes.url_helpers }
  let(:comment) { Comment.find(1) }

  it 'resolves url' do
    url = url_helpers.resource_url_for(comment, only_path: true)
    expect(url).to eq("/items/#{comment.item_id}/comments/#{comment.id}")
  end
end
