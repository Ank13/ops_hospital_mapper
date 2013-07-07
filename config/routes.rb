OpsHospitalMapper::Application.routes.draw do

    root :to => 'maps#index'

    resources :maps, :only => [:index]
 
    resources :hospitals do
      member do
        get 'infobox'
        get 'outcomebox'
      end
    end 

end
