Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do  
    namespace :v1 do

      constraints format: :json do
        
        match '/index', :to => "api#index", :via => :all

        match "/register", :to => "users#new", :via => :get
        match "/register", :to => "users#create", :via => [:put, :post]

        match '/users',     :to => "users#index", :via => :get
        match '/users/:id', :to => "users#show", :via => :get
        match '/users',     :to => "users#destroy", :via => :delete

        match "/login",  :to => "sessions#new", :via => :get
        match "/login",  :to => "sessions#create", :via => [:put, :post]
        match "/logout", :to => "sessions#destroy", :via => :delete
  
        match "/posts",     :to => "posts#create", :via => [:put, :post]
        match "/posts/:id", :to => "posts#destroy", :via => :delete

        match "/comments",     :to => "comments#create", :via => [:put, :post]
        match "/comments/:id", :to => "comments#destroy", :via => :delete

        match '/todos', :to => "todos#index", :via => :get
        match '/todos', :to => "todos#create", :via => [:put, :post]
        match '/todos', :to => "todos#destroy", :via => :delete

      end
    end
  
  end

end
