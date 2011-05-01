Rails.application.routes.draw do
  namespace :interpreter do
    resources :translations
  end
end
