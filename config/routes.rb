Rails.application.routes.draw do
  root 'homes#top'

  devise_for :users, path: 'users', skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions',
  }

  scope module: 'public' do
    get '/users/mypage',      to: 'users#show',         as: 'mypage'
    get '/users/unsubscribe', to: 'users#unsubscribe',  as: 'unsubscribe_users'
    patch '/users/withdraw',  to: 'users#withdraw',     as: 'withdraw_users'

    # 達成確認画面でリロードした場合にshowを呼び出さないようにする
    get '/targets/confirm',   to: 'targets#error',      as: 'error_targets'
    resources :targets do
      collection do
        post  :confirm
        get   :complete
      end
    end
    resources :unlock_lists, only: [:index]
    resources :tasks, only: [:create, :destroy]
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions',
  }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
