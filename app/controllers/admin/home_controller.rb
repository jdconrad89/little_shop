class Admin::HomeController < ApplicationController
  before_action :require_admin

  def index
    @items = Item.all
    
    @cart_items = cart.items
  end
end
