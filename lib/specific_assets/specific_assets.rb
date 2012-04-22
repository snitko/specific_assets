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
        (filter_class_assets("js") + @js_specific).uniq
      else
        @js_specific
      end
    end

    # This method is called in view to include all css assets:
    #   css_assets.each { |css| stylesheet_link_tag(css) }
    def css_assets
      unless self.class.css_specific.nil?
        (filter_class_assets("css") + @css_specific).uniq
      else
        @css_specific
      end
    end

    def initialize_assets
      @js_specific  ||= []
      @css_specific ||= []
    end

    private
      
      # Because assets end up being collected in a class variable
      # assets from other controllers usually end up in the controller
      # that has nothing to do with them. This method filters assets
      # and returns the ones which are relevant to the current controller.
      def filter_class_assets(asset_type)
        self.class.send("#{asset_type}_specific").map { |a| a[:controller] == self.class.to_s ? a[:asset] : nil }.compact
      end

  end

  module ClassMethods
    
    def add_js(*assets)
      self.js_specific = [] if js_specific.nil?
      # Storing current controller name in the key
      self.js_specific = js_specific + label_assets_with_controller_name(assets)
    end

    def add_css(*assets)
      self.css_specific = [] if self.css_specific.nil?
      # Storing current controller name in the key
      self.css_specific = self.css_specific + label_assets_with_controller_name(assets)
    end

    private

      def label_assets_with_controller_name(assets)
        assets.map! { |a| { :controller => self.to_s, :asset => a } }
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
