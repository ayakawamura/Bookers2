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
    resource :favorites,only:[:create,:destroy]
    resources :book_comments,only:[:create,:destroy]
  end

  resources :users,only:[:show,:edit,:update,:index] 
  resources :relationships,only:[:create,:destroy]
    get "relationships/follower" => "relationships#follower"
    get "relationships/followed" => "relationships#followed"
  

end
