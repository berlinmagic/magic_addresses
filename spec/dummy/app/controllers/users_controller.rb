# encoding: utf-8
class UsersController < ApplicationController


  def index
    @users = User.all
  end


  def create
    @user = User.new( user_params )
    if @user.save
      redirect_to users_path, notice: "User created!"
    else
      redirect_to root_path, alert: "Couldn't create User! .. #{ @user.errors.full_messages.join("<br />") }"
    end
  end



  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :address_attributes => [:street, :number, :postalcode, :city, :country])
    end

end
