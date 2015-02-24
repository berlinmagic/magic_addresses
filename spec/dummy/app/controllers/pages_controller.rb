# encoding: utf-8
class PagesController < ApplicationController
  
  def start
    @user = User.new()
  end
  
end
