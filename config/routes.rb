Rails.application.routes.draw do
  resources :articles do
    resources :comments
  end
  resources :tags
  resources :categories
  resources :users
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
  },
  controllers: {
    sessions: 'users/sessions',
  }
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
