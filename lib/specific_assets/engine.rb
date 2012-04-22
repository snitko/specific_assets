module SpecificAssets

  class Engine < Rails::Engine

    initializer 'specific_assets.controller' do |app|  
      ActiveSupport.on_load(:action_controller) do  
        include SpecificAssets
      end
    end 

  end

end
