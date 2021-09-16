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
  
  resources :books,only:[:index,:create,:show,:edit,:update,:destroy]
  
  resources :users,only:[:show,:edit,:update]
  
end
