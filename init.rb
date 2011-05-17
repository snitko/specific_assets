require File.dirname(__FILE__) + '/lib/specific_assets'

ActionController::Base.class_eval do
  include SpecificAssets
end
