Rails.application.routes.draw do
  namespace :interpreter do
    resources :translations do
      collection do
        post 'search'
        get '/group/:category' => 'translations#index', :as => 'category'
      end
    end
  end
end
