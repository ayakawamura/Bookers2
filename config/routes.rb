Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "homes#top"
  get "home/about" => "homes#about"

  resources :books, only: [:index, :create, :show, :edit, :update, :destroy] do
    # いいね自体にIDはいらないので単数系
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :update, :index] do
    # userコントローラーに一覧ベージを作る場合の記述
    # member do
    # get :following, :followers
    # end
    resource :relationships, only: [:create, :destroy]
    # relationshipsコントローラーに一覧ページを作る際の記述
    get 'following' => 'relationships#following', as: 'following'
    get 'followers' => 'relationships#followers', as: 'followers'
    get "posted_search" => "users#search", as: "posted_search"
    # as以下は○○_path部分の指定
  end

  get "search" => "searches#search", as: "search"

  resources :groups do
    get "join" => "groups#join", as: "join"
    delete "groupdelete" => "groups#groupdelete", as: "groupdelete"
    get "mail" => "groups#mail", as: "mail"
    get "send/mail" => "groups#send_mail"
  end

  # チャット
  resources :rooms, only: [:new, :create, :show]

  resources :messages, only: [:create]
end
