Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  # 名前付きルーティング
  get 'homes/about' => 'homes#about', as: "about"
  
  # resourceを使って自動生成
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  resources :users, only: [:show, :edit, :index, :update]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end



#           user_session POST   /users/sign_in(.:format)     devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)     devise/sessions#destroy
#       new_user_password GET    /users/password/new(.:format)     devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format)    devise/passwords#edit
#           user_password PATCH  /users/password(.:format)          devise/passwords#update
#                         PUT    /users/password(.:format)   devise/passwords#update
#                         POST   /users/password(.:format)     devise/passwords#create
# cancel_user_registration GET    /users/cancel(.:format)    devise/registrations#cancel
#   new_user_registration GET    /users/sign_up(.:format)      devise/registrations#new
#   edit_user_registration GET    /users/edit(.:format)    devise/registrations#edit
#       user_registration PATCH  /users(.:format)  devise/registrations#update
#                         PUT    /users(.:format) devise/registrations#update
#                         DELETE /users(.:format)  devise/registrations#destroy
#                         POST   /users(.:format)   devise/registrations#create
#                     root GET    /        homes#top
#                   about GET    /homes/about(.:format)    homes#about
#                   books GET    /books(.:format)      books#index
#                 new_book GET    /books/new(.:format)         books#new
#                     book GET    /books/:id(.:format)      books#show