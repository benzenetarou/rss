Rails.application.routes.draw do
  root 'feeds#index'
  get 'feeds/new'

  get 'feeds/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
