Rails.application.routes.draw do

  root to: 'posts#top'

# Usersコントローラルーティング
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: "users/sessions",
  }
  get 'users/withdraw_view'
  patch '/users/:id/withdraw' => 'users#withdraw', as: 'user_withdraw'
  patch '/users/:id/admin' => 'users#admin', as: 'user_admin'
  resources :users, only: [:index, :show, :edit, :update]

# Postsコントローラルーティング
  get 'posts/top'
  get 'posts/about'
  get 'posts/hashtag'
  get 'posts/search_result'
  post 'posts/album' => 'posts#album_in', as: 'posts_album_in'
  delete 'posts/album' => 'posts#album_out', as: 'posts_album_out'
  resources :posts

# Albumsコントローラルーティング
  resources :albums, only: [:index, :show, :create, :destroy]

# Favoritesコントローラルーティング
  resources :favorites, only: [:create, :destroy]

# Roomsコントローラルーティング
  resources :rooms, only: [:index, :show, :create, :destroy]

# Contactsコントローラルーティング
  resources :contacts, only: [:index, :show, :create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
