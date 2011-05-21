Rails.application.routes.draw do
  namespace :interpreter do
    resources :translations do
      collection do
        post 'search'
      end
    end
  end
end
