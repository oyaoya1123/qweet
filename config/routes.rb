Rails.application.routes.draw do
  devise_for :users
  # root to: 'questions#index'
  root to: "questions#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :questions do
    resources :answers
    resources :question_categorys
    #resources :categorys, only: :index
    collection do
      get 'search'
    end
  end
  resources :categorys do
    resources :questions, only: :index
  end
  #get 'questions' => 'questions#index_category'
end
