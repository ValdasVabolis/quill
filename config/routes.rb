Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root to: 'home#index'

  resources :inquiries, only: [:new, :create]

  # get 'users/question/:id', to: 'users/questions#show'db
  # public profiles
  get 'users/:username', to: 'users#show', as: 'user_profile'
  # private profiles
  get 'account', to: redirect('/account/profile'), as: :my_account
  get 'account/profile', to: 'accounts#profile'
  # settings
  get 'account/questions', to: 'accounts#questions'
  get 'account/answers', to: 'accounts#answers'

  # /users
  namespace :users do 
    get 'questions/:id', to: 'questions#show', constraints: { id: /\d*/ }
    authenticate :user do
      get 'questions/exit', to: 'questions#exit', as: 'questions_exit'
      resources :questions, except: [:show]
      match 'question/:id/vote/:type', to: 'questions#vote', via: :put
      namespace :questions do
        resources :answers, except: [:new, :show]
        match 'answers/:id/reply', to: 'answers#reply', via: :get
        match 'answer/:id/vote/:type', to: 'answers#vote', via: :put
      end
    end
  end
end