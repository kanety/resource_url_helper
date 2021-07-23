10.times do |i|
  Item.create
  Comment.create(item_id: i + 1)
end
