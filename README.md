# ResourceUrlHelper

Complement required url parameters from resource.

## Dependencies

* ruby 2.7+
* rails 6.0+

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'resource_url_helper'
```

Then execute:

    $ bundle

## Usage

Prepare model and it's route:

```ruby
class Comment < ActiveRecord::Base
end

Rails.application.routes.draw do
  resources :comments, path: 'items/:item_id/comments' # :item_id is required
end
```

Use `resource_url_for` as follows:

```ruby
comment = Comment.find(1)
comment.item_id = 2

# `resource_url_for` complements :itemt_id from comment attributes automatically
Rails.application.routes.url_helpers.resource_url_for(comment, only_path: true)
#=> "/items/2/comments/1"

# Against upper example, `url_for` needs :item_id explicitly
Rails.application.routes.url_helpers.url_for(comment, item_id: comment.item_id, only_path: true)
```

You can use `resource_url_for` in your controller or view:

```ruby
class CommentsController < ActionController::Base
  def show
    comment = Comment.find(1)
    comment.item_id = 2

    resource_url_for(comment)
    #=> "/items/2/comments/1"
  end
end 
```

### Complementation from resource association

This gem supports complementation from resource association:

```ruby
class Association::Comment
  belongs_to :item
end

Rails.application.routes.draw do
  resources :association_comments, path: 'items/:item/comments' # :item is required
end

comment = Association::Comment.find(1)
comment.item = Item.find(2)

Rails.application.routes.url_helpers.resource_url_for(comment, only_path: true)
#=> "/items/2/comments/1"
```

In case associated object is not found, `0` is filled as follows:

```ruby
comment = Association::Comment.find(1)
comment.item = nil

Rails.application.routes.url_helpers.resource_url_for(comment, only_path: true)
#=> "/items/0/comments/1"
```

## Contributing

Bug reports and pull requests are welcome at https://github.com/kanety/resource_url_helper.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
