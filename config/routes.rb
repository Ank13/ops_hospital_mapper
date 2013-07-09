OpsHospitalMapper::Application.routes.draw do

    root :to => 'maps#index'

    resources :maps, :only => [:index]

    get 'maps/more_markers', to: 'maps#more_markers', as: :more_markers
 
    resources :hospitals do
      member do
        get 'infobox'
        get 'outcomebox'
        get 'complicationbox'
      end
    end 

end
