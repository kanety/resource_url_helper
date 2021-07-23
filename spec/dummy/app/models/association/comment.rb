class Association::Comment< ActiveRecord::Base
  belongs_to :item, class_name: 'Item'
end
