OpsHospitalMapper::Application.routes.draw do

    root :to => 'maps#index'

    resources :maps, :only => [:index, :show]
    match '/about', to: 'maps#show'

    resources :hospitals do
      member do
        get 'infobox'
      end
     end 

end
