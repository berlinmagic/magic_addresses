# encoding: utf-8
class MagicAddresses::BaseController < ApplicationController
  
  # => layout proc { |controller| controller.request.xhr? ? false : "application" }
  
  include MgcaHelper
  
  before_action :authenticate_visitor
  
  
  private

    # overwrite for authentication
    def authenticate_visitor
      true
    end

end
