Rails.application.routes.draw do
  devise_for :users
  resources :testes
  
  resources :articles do
    resources :comments
  end
  
  resources :categories

  root "articles#index"
  



  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
