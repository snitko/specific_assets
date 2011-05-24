require 'spec_helper'
require 'specific_assets'

Rails.application.routes.draw do
  match '/:controller(/:action(/:id))'
end

class SomeController < ApplicationController
  add_css "yo"
  def hello
    add_js  "hello", "hi"
    add_css "hello", "hi"
    render :text => "hello"
  end
end

describe SomeController, :type => :controller do

  before(:each) do
    @controller = SomeController.new
  end

  it "adds css and js file names to the list" do
    get :hello
    @controller.css_assets.should include("hello")
    @controller.css_assets.should include("hi")
    @controller.css_assets.should include("yo")
    @controller.js_assets.should  include("hello")
    @controller.js_assets.should  include("hi")
  end

end
