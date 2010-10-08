RRetro::Application.routes.draw do

  resources :retrospectives  do
    post :refresh, :on => :member
    post :refresh_groups, :on => :member
    post :update_title, :on => :member

    resources :sections do
      post :add, :on => :collection
      post :update_title, :on => :member
      post :move_item_to, :on => :member

      resources :items do
        post :add, :on => :collection
        post :update_value, :on => :member
        post :refresh_value, :on => :member
        post :vote_for, :on => :member
        post :remove_vote, :on => :member
        post :remove_from_group, :on => :member
      end

    end

    #, :only => [:add]
    resources :groups do
      post :add, :on => :collection
      post :update_title, :on => :member
      post :add_item, :on => :member
    end
  end

  root :to => "retrospectives#index"

end
