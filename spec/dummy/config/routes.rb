Rails.application.routes.draw do
  root to: "items#index"
  resources :items
  resources :comments, path: 'items/:item_id/comments'
  resources :association_comments, path: 'items/:item/comments'
end
