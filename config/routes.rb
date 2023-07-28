Rails.application.routes.draw do

 #ユーザー用
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  #ゲストログイン
  devise_scope :user do
    post 'users/guest_log_in', to: 'public/sessions#guest_log_in'
  end


  scope module: :public do

    root to: 'homes#top'

    get 'about' => 'homes#about'

    get 'users' => 'users#index'
    get 'users/mypage/:id' => 'users#show', as: 'users_mypage'
    get 'users/:id/edit' => 'users#edit', as: 'edit_user'
    patch 'users/:id' => 'users#update', as: 'update_user'
    get 'users/other_user/:id' => 'users#other_user', as: 'other_user'
    resources :trip_articles do
      resources :comments, only: [:create, :destroy]
      resources :likes, only: [:create, :destroy]
    end

    resources :likes, only: [:index]
    get 'search' => 'searches#search'
  end
    resources :tags do
      get 'trip_article', to: 'trip_article#search'
    end
#管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do

    get '/' => 'homes#top'

    resources :users, only: [:index, :destroy]
    resources :trip_article, only: [:destroy]
    resources :comments, only: [:index, :destroy]
    resources :tags, only: [:index, :create, :edit, :update, :destroy]

  end
end
