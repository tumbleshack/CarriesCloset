class UsersController < ApplicationController

    # make sure you cannot delete yourself
    
    def new
        @users = User.all
        render 'users/manage'
    end

    def index
        @users = User.all
        render 'users/manage'
    end
    
    def manage
        @users = User.all
        render 'users/manage'
    end

    def set_user
        @user = User.find(params[:id])
      end

  end