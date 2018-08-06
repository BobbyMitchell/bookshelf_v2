Rails.application.routes.draw do
  mount Attachinary::Engine => "/attachinary"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 resources :books do
  resources :user_books do
    end
     get 'books/:user_id', to: 'books#their_books'

  collection do
    get "my_books", to: "books#my_books"
    get "my_reading_list", to: "books#my_reading_list"
    get "select_book", to: "books#select_book"
    end
  # member do
    # get "add_to_my_bookshelf", to: "books#add_to_my_bookshelf"
    # get "remove_from_my_bookshelf", to: "books#remove_from_my_bookshelf"
    # get "add_to_my_reading_list", to: "books#add_to_my_reading_list"
    # get "remove_from_my_bookshelf", to: "books#remove_from_my_bookshelf"
  # end
 end
 root to: "books#index"
end
