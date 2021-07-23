describe ResourceUrlHelper::Controller, type: :request do
  let(:comment) { Comment.find(1) }

  it 'resolves url' do
    get comment_path(id: comment, item_id: comment.item_id)
    expect(response.body).to include("/items/#{comment.item_id}/comments/#{comment.id}")
  end
end
