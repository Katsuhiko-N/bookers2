Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  # 名前付きルーティング
  get 'home/about' => 'homes#about', as: "about"
  
  # resourceを使って自動生成
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy] do
    resource :favorite, only: [:create, :destroy]
  end
  
  resources :users, only: [:show, :edit, :index, :update] do
    resource :relationship, only: [:create, :destroy] do
      collection do
        get 'follower_index'
        get 'followed_index'
      end
    end
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end



#     root GET    /                        homes#top
#   about GET    /homes/about(.:format)     homes#about
#   books GET    /books(.:format)             books#index
#         POST   /books(.:format)            books#create
# new_book GET    /books/new(.:format)          books#new
# edit_book GET    /books/:id/edit(.:format)   books#edit
#     book GET    /books/:id(.:format)    books#show
#         PATCH  /books/:id(.:format)     books#update
#         PUT    /books/:id(.:format)      books#update
#         DELETE /books/:id(.:format)       books#destroy
#   users GET    /users(.:format)           users#index
# edit_user GET    /users/:id/edit(.:format)      users#edit
#     user GET    /users/:id(.:format)          users#show
#         PATCH  /users/:id(.:format)         users#update
#         PUT    /users/:id(.:format)     users#update