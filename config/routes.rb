Rails.application.routes.draw do

 #ユーザー用
  devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

 scope module: :public do

   root to: 'homes#top'

   get 'about' => 'homes#about'

   get 'users' => 'users#index'
   #get 'users/new' => 'users#new'
   get 'users/mypage' => 'users#show'
   get 'users/edit' => 'users#edit'
   patch 'users/update' => 'users#update'

   resources :trip_articles
   resources :comments, only: [:create, :destroy]

   #resources :bookmark, only[:index, :destoroy]

  end
#管理者用
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
namespace :admin do

  get '/' => 'homes#top'

  resources :users, only: [:index, :destroy]
  resources :comment, only: [:index, :destroy]
end
end
