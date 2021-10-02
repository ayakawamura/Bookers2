Rails.application.routes.draw do
  # get 'users/show'
  # get 'users/edit'
  # get 'books/index'
  # get 'books/show'
  # get 'books/edit'
  # get 'homes/top'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "homes#top"
  get "home/about" => "homes#about"

  resources :books,only:[:index,:create,:show,:edit,:update,:destroy] do
    # いいね自体にIDはいらないので単数系
    resource :favorites,only:[:create,:destroy]
    resources :book_comments,only:[:create,:destroy]
  end

  resources :users,only:[:show,:edit,:update,:index] do
    member do
    get :following, :followers
    end
    resource :relationships,only:[:create,:destroy]
    get 'following' => 'relationships#following', as: 'following'
    get 'followers' => 'relationships#followers', as: 'followers'
        # as以下は○○_path部分の指定
  end
end
