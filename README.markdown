specific_assets
======

*Rails extension to easily add custom css and js in controllers and views*

Why do you need this?
------------------------
Ever needed to add different css and js to different pages of the website, but felt that
creating a new layout would be an overkill?

Now you can just say:

    add_css "registration", "some_other_fancy_stuff"
    add_js "registration"

and you'll get respective css and js files included into the page.
	

INSTALLATION
------------

	gem install specific_assets

Usage
---------------

First, you should add this to your layout:

    js_assets.each { |js| javascript_include_tag(js) }
    css_assets.each { |css| stylesheet_link_tag(css) }

Now you're ready to use `#add_js` and `#add_css` methods. Those methods are available as helpers in views, and both as instance and class methods in controllers. If class methods are used, then assets will be added for all the actions in the controller.

Usage examples:

    class UsersController < ApplicationController

      add_css "users"
      add_js "users"

      def new
        add_css "new_user"
      end

      def show
        add_js "user_profile", "user_animations"
      end

    end
