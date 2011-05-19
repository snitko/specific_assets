module SpecificAssets

  module InstanceMethods
    
    def add_js(*asset_name)
      @js_specific += asset_name
    end

    def add_css(*asset_name)
      @css_specific += asset_name
    end

    # This method is called in view to include all js assets:
    #   js_assets.each { |js| javascript_include_tag(js) }
    def js_assets
      unless self.class.js_specific.nil?
        (self.class.js_specific + @js_specific).uniq
      else
        @js_specific
      end
    end

    # This method is called in view to include all css assets:
    #   css_assets.each { |css| stylesheet_link_tag(css) }
    def css_assets
      unless self.class.css_specific.nil?
        (self.class.css_specific + @css_specific).uniq
      else
        @css_specific
      end
    end

    def initialize_assets
      @js_specific  ||= []
      @css_specific ||= []
    end


  end

  module ClassMethods
    
    def add_js(*asset_name)
      self.js_specific = [] if js_specific.nil?
      self.js_specific = js_specific + asset_name
    end

    def add_css(*asset_name)
      self.css_specific = [] if self.css_specific.nil?
      self.css_specific = self.css_specific + asset_name
    end

  end

  
  def self.included(base)
    base.extend ClassMethods
    base.class_eval do
      include InstanceMethods
      cattr_accessor :js_specific, :css_specific
      helper_method :add_js, :add_css, :js_assets, :css_assets
      before_filter :initialize_assets
    end
  end

end
