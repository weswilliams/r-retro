RRetro::Application.routes.draw do

  resources :retrospectives  do
    post :refresh, :on => :member
    
    resources :sections do
      post :update_title, :on => :member
      post :move_item_to, :on => :member
      resources :items do
        post :add, :on => :collection
        post :update_value, :on => :member
        post :vote_for, :on => :member
        post :remove_vote, :on => :member
      end
    end
  end

  root :to => "retrospectives#index"

end
