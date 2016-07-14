Rails.application.routes.draw do
  root 'home#index'
  resources :home do
    collection do
      post 'requests'
    end
  end
  resources :wechat
end
