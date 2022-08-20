Rails.application.routes.draw do
  get 'users/login'
  post 'users', to: "users#create"
  get 'users/auto_login'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
