Rails.application.routes.draw do

  root 'categories#index'


  resources :articles do
    get :search
  end
  resources :categories do
    get :search
  end



end
