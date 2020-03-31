Rails.application.routes.draw do
	devise_for :users
    resources :users, only: [:edit, :update, :create, :index, :show]
    resources :books
    root 'homes#top'
    get '/home/about' => 'homes#about'
end
