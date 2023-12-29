Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      devise_for :users, path: '', controllers: {
        registrations: "api/v1/registrations",
        tokens: "api/v1/tokens"
      }
      resources :categories
      resources :posts do
        member do
          post "like"
          post "vote"
        end
      end
      resources :comments, except: :index do
        member do
          post "like"
          post "vote"
        end
      end
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
