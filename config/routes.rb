Rails.application.routes.draw do
  devise_for :users
  root 'feeds#index'
  get '/feeds/new', to: 'feeds#new'
  post 'feeds/confirm', to: 'feeds#confirm'
  post 'feeds/create', to: 'feeds#create'
  get 'feeds/show'
  get 'feeds/list', to: 'feeds#list'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
