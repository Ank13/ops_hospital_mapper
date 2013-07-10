OpsHospitalMapper::Application.routes.draw do

    root :to => 'maps#index'

    resources :maps, :only => [:index]

    post 'procedures/prices', to: 'procedures#prices', as: :prices
    get 'maps/more_markers', to: 'maps#more_markers', as: :more_markers

    get 'maps/popup', to: 'maps#popup', as: :popup
    
    get 'maps/analytics',  to: 'maps#analytics', as: :analytics


    resources :hospitals do
      member do
        get 'infobox'
        get 'outcomebox'
        get 'complicationbox'
      end
    end 

end
